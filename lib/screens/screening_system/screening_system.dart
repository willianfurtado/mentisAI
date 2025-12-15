import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/screening_system/analysis_card.dart';
import 'package:mentis_ai/screens/widgets/screening_system/cluster_gauge.dart';
import 'package:mentis_ai/screens/widgets/screening_system/screenning_recommendation_card.dart';

class ScreeeningSystem extends StatelessWidget {
  const ScreeeningSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  'Sistema de triagem e alerta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),

              //Seção de classificação de cluster
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Classificação de Cluster',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //gráfico de avaliação de cluster
                        ClusterGauge(
                            clusterScore: 78.0,
                            clusterClassification: 'Grupo de alto risco'),
                      ],
                    ),
                    const SizedBox(height: 30),

                    //Seção Análise detalhada
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          padding: const EdgeInsets.all(0),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.0,
                          children: const [
                            AnalysisCard(
                                text: 'Sua VFC está 25% abaixo do normal'),
                            AnalysisCard(
                              text:
                                  'Você teve um aumento nas chamadas rejeitadas',
                            ),
                            AnalysisCard(
                                text: 'A média de passos semanais caiu'),
                            AnalysisCard(
                              text:
                                  'Você teve um aumento nas chamadas rejeitadas',
                            ),
                            // Adicione mais cards se necessário para preencher o Grid
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recomendações',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        //card de recomendação
                        RecomendationCard(),
                      ],
                    ),
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
