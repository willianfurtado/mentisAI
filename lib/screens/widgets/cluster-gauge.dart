import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ClusterGauge extends StatelessWidget {
  // A pontuação atual do cluster (de 0 a 100)
  final double clusterScore;
  // O texto que representa a classificação (ex: "Alto Risco")
  final String clusterClassification;

  const ClusterGauge({
    super.key,
    required this.clusterScore,
    required this.clusterClassification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20.0), // Borda arredondada, como no design
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Título superior
          const Text(
            'Sua avaliação de bem-estar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 5),

          // 🎯 O WIDGET PRINCIPAL DO MEDIDOR
          SizedBox(
            height: 180,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100, // Escala de 0 a 100
                  startAngle: 180, // Início (esquerda)
                  endAngle: 0, // Fim (direita)

                  // Oculta elementos de escala para um visual limpo
                  showLabels: false,
                  showTicks: false,
                  // showPointer: false,

                  // Faixas de Cores (Ranges) - Laranja e Cinza
                  ranges: <GaugeRange>[
                    // Faixa Laranja (Progresso)
                    GaugeRange(
                      startValue: 0,
                      endValue: clusterScore, // Preenchido até a pontuação
                      color: Colors.orange.shade400, // Cor Laranja do design
                      startWidth: 25,
                      endWidth: 25,
                    ),
                    // Faixa Cinza (Restante)
                    GaugeRange(
                      startValue: clusterScore,
                      endValue: 100,
                      color: Colors.grey.shade300, // Cor Cinza do design
                      startWidth: 25,
                      endWidth: 25,
                    ),
                  ],

                  // Marcador de Limite (O pequeno traço preto)
                  pointers: <GaugePointer>[
                    MarkerPointer(
                      value: clusterScore, // Posição do traço
                      markerHeight: 18,
                      markerWidth: 3,
                      markerType: MarkerType.rectangle,
                      color: Colors.black,
                      enableDragging: false,
                    ),
                  ],

                  // Texto Central (Classificação do Cluster)
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        clusterClassification, // Ex: 'Grupo de alto risco'
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      angle: 90, // Posição no centro-inferior
                      positionFactor: 0.8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
