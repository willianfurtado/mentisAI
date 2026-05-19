import 'package:flutter/material.dart';
import 'package:mentis_ai/services/health_sync_service.dart';
import 'package:mentis_ai/services/prediction_service.dart';
import 'package:mentis_ai/screens/widgets/screening_system/analysis_card.dart';
import 'package:mentis_ai/screens/widgets/screening_system/cluster_gauge.dart';
import 'package:mentis_ai/screens/widgets/screening_system/screenning_recommendation_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreeeningSystem extends StatefulWidget {
  // recebe os dados da Home
  final int steps;
  final double calories;
  final int heartRate;
  final int sleepMinutes;

  const ScreeeningSystem({
    super.key,
    required this.steps,
    required this.calories,
    required this.heartRate,
    required this.sleepMinutes,
  });

  @override
  State<ScreeeningSystem> createState() => _ScreeeningSystemState();
}

class _ScreeeningSystemState extends State<ScreeeningSystem> {
  int _clusterResult = -1;
  String _label = "Analisando dados...";
  double _score = 0.0;
  bool _isLoading = true;
  DateTime? _lastUpdate;

  @override
  void initState() {
    super.initState();
    _checkAndPredict();
  }

  Future<void> _checkAndPredict() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSyncStr = prefs.getString('last_sync_time');
    final now = DateTime.now();

    if (lastSyncStr != null) {
      final lastSync = DateTime.parse(lastSyncStr);
      final difference = now.difference(lastSync).inMinutes;

      if (difference < 60) {
        setState(() {
          _lastUpdate = lastSync;
          _clusterResult = prefs.getInt('last_cluster') ?? -1;
          _label = prefs.getString('last_label') ?? "Análise recente";
          _score = prefs.getDouble('last_score') ?? 0.0;
          _isLoading = false;
        });
        return;
      }
    }
    await _syncAndPredict();
  }

  Future<void> _syncAndPredict() async {
    try {
      final healthSync = HealthSyncService();
      final predictionService = PredictionService();

      final data = await healthSync.pushDatatoModel(DateTime.now());

      if (data != null) {
        final result = await predictionService.getPredictionCluster(data);

        if (result != null && result.containsKey('cluster_principal')) {
          final int cluster = result['cluster_principal'];

          _updateUIWithCluster(cluster);

          final prefs = await SharedPreferences.getInstance();
          final now = DateTime.now();
          await prefs.setString('last_sync_time', now.toIso8601String());
          await prefs.setInt('last_cluster', cluster);
          await prefs.setString('last_label', _label);
          await prefs.setDouble('last_score', _score);

          setState(() {
            _lastUpdate = now;
            _isLoading = false;
          });
        }
      } else {
        _handleError("Não foi possível sincronizar dados");
      }
    } catch (e) {
      _handleError("Erro na predição: $e");
    }
  }

  void _updateUIWithCluster(int cluster) {
    setState(() {
      _clusterResult = cluster;
      switch (cluster) {
        case 1:
          _label = "Risco Baixo";
          _score = 25.0;
          break;
        case 2:
          _label = "Risco Moderado-Baixo";
          _score = 50.0;
          break;
        case 0:
          _label = "Risco Moderado-Alto";
          _score = 75.0;
          break;
        case 3:
          _label = "Risco Alto";
          _score = 100.0;
          break;
        default:
          _label = "Análise inconclusiva";
          _score = 0.0;
      }
    });
  }

  void _handleError(String message) {
    if (mounted) {
      setState(() {
        _label = message;
        _isLoading = false;
      });
    }
  }

  String _formatSleep(int minutes) {
    if (minutes == 0) return "--";
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return "${hours}h ${mins}m";
  }

  bool get canUpdate =>
      _lastUpdate == null ||
      DateTime.now().difference(_lastUpdate!).inMinutes >= 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    const Expanded(
                      child: Text('Triagem e alerta',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton.icon(
                      onPressed: canUpdate ? _syncAndPredict : null,
                      icon: Icon(canUpdate ? Icons.refresh : Icons.check,
                          size: 18),
                      label: Text(canUpdate ? "Atualizar" : "Atualizado"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        disabledBackgroundColor: Colors.grey[300],
                      ),
                    ),
                  ])),
              const SizedBox(height: 30),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Classificação de Cluster',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              ClusterGauge(
                                clusterScore: _score,
                                clusterClassification: _label,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Análise detalhada',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.0,
                            children: [
                              AnalysisCard(text: 'Passos: ${widget.steps}'),
                              AnalysisCard(
                                  text:
                                      'Calorias: ${widget.calories.toInt()} kcal'),
                              AnalysisCard(
                                  text:
                                      'FC Atual: ${widget.heartRate > 0 ? widget.heartRate : "--"} bpm'),
                              AnalysisCard(
                                  text:
                                      'Sono: ${_formatSleep(widget.sleepMinutes)}'),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Recomendações',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          RecomendationCard(clusterIndex: _clusterResult),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
