import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/widgets/analysis-card.dart';
import 'package:mentis_ai/screens/widgets/screenning-recommendation-card.dart';

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
                child: Text(
                  'Sistema de triagem e alerta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),

              Column(
                children: [
                  Text(
                    'Classificação de Cluster',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  //gráfico de avaliação de cluster
                ],
              ),
              const SizedBox(height: 150),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Análise detalhada',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap:
                        true, 
                    physics:
                        const NeverScrollableScrollPhysics(), 
                    padding: const EdgeInsets.all(
                      0,
                    ), 
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio:
                        1.5,
                    children: const [
                      AnalysisCard(text: 'Sua VFC está 25% abaixo do normal'),
                      AnalysisCard(
                        text: 'Seu descanso noturno foi interrompido',
                      ),
                      // Adicione mais cards se necessário para preencher o Grid
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 150),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recomendações',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  //card de recomendação
                  RecomendationCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
