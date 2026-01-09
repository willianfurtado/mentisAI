import 'package:flutter/material.dart';
import 'package:mentis_ai/services/prediction_service.dart'; // Importe seu serviço
import 'package:mentis_ai/screens/widgets/screening_system/analysis_card.dart';
import 'package:mentis_ai/screens/widgets/screening_system/cluster_gauge.dart';
import 'package:mentis_ai/screens/widgets/screening_system/screenning_recommendation_card.dart';

class ScreeeningSystem extends StatefulWidget {
  const ScreeeningSystem({super.key});

  @override
  State<ScreeeningSystem> createState() => _ScreeeningSystemState();
}

class _ScreeeningSystemState extends State<ScreeeningSystem> {
  final PredictionService _aiService = PredictionService();

  // Variáveis para controlar o estado da UI
  int _clusterResult = -1; // -1 significa "carregando"
  String _label = "Analisando dados...";
  double _score = 0.0;
  bool _isLoading = true;

  // Dados de exemplo (que virão do Health Connect)
  int passosHj = 3500;
  double calHj = 1500.0;

  @override
  void initState() {
    super.initState();
    _loadAndPredict();
  }

  Future<void> _loadAndPredict() async {
    // 1. Carrega o modelo JSON 
    await _aiService.loadModel();

    int cluster = _aiService.predict([passosHj.toDouble(), calHj]);

    if (mounted) {
      setState(() {
        _clusterResult = cluster;
        _isLoading = false;

        // Importante: Verifique no seu Colab qual ID (0, 1 ou 2) corresponde a cada grupo
        switch (cluster) {
          case 0:
            _label = "Nível Ativo / Saudável";
            _score = 30.0;
            break;
          case 1:
            _label = "Nível Moderado";
            _score = 65.0;
            break;
          case 2:
            _label =  "Grupo de Risco (Sedentarismo)";
            _score = 90.0;
            break;
          default:
            _label = "Erro na análise";
            _score = 0.0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
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

                              // 🎯 AQUI O FEEDBACK DA IA É RENDERIZADO
                              ClusterGauge(
                                clusterScore: _score,
                                clusterClassification: _label,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Seção Análise detalhada
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
                              AnalysisCard(
                                  text:
                                      'Passos hoje: 3500'), // Exemplo dinâmico
                              const AnalysisCard(
                                  text: 'Sua VFC está 25% abaixo'),
                              const AnalysisCard(
                                  text: 'Aumento em chamadas rejeitadas'),
                              const AnalysisCard(
                                  text: 'Sono: 6h média semanal'),
                            ],
                          ),
                          const SizedBox(height: 25),

                          const Text(
                            'Recomendações',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          // Opcional: Passar o cluster para personalizar a recomendação
                          const RecomendationCard(),
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
