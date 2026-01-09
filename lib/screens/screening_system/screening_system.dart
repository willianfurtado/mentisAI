import 'package:flutter/material.dart';
import 'package:mentis_ai/services/prediction_service.dart';
import 'package:mentis_ai/screens/widgets/screening_system/analysis_card.dart';
import 'package:mentis_ai/screens/widgets/screening_system/cluster_gauge.dart';
import 'package:mentis_ai/screens/widgets/screening_system/screenning_recommendation_card.dart';

class ScreeeningSystem extends StatefulWidget {
  // 1. Campos adicionados para receber os dados da Home
  final int steps;
  final double calories;
  final int heartRate; // Adicionado
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
  final PredictionService _aiService = PredictionService();

  int _clusterResult = -1;
  String _label = "Analisando dados...";
  double _score = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAndPredict();
  }

  Future<void> _loadAndPredict() async {
    // Carrega o modelo JSON
    await _aiService.loadModel();

    // 2. Uso dos dados reais passados pelo widget (vindo da Home)
    int cluster =
        _aiService.predict([widget.steps.toDouble(), widget.calories]);

    if (mounted) {
      setState(() {
        _clusterResult = cluster;
        _isLoading = false;

        // Mapeamento baseado na análise do seu Colab
        switch (cluster) {
          case 0: // Geralmente o grupo Ativo (confira no seu Python)
            _label = "Nível Ativo / Saudável";
            _score = 30.0;
            break;
          case 1: // Moderado
            _label = "Nível Moderado";
            _score = 65.0;
            break;
          case 2: // Risco
            _label = "Grupo de Risco (Sedentarismo)";
            _score = 90.0;
            break;
          default:
            _label = "Erro na análise";
            _score = 0.0;
        }
      });
    }
  }

  String _formatSleep(int minutes) {
    if (minutes == 0) return "--";
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return "${hours}h ${mins}m";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adicionado um AppBar simples para facilitar a navegação de volta
      // appBar: AppBar(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     iconTheme: const IconThemeData(color: Colors.black)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Sistema de triagem e alerta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
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
                              // 3. Exibição dinâmica dos passos reais
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
