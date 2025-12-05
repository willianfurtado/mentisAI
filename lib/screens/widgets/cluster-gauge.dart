import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ClusterGauge extends StatelessWidget {
  final double clusterScore;
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
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Column(
        children: [
          // Título superior
          const Text(
            'Sua avaliação de bem-estar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),

          SizedBox(
            height: 170,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100, // Escala de 0 a 100
                  startAngle: 180, // Início (esquerda)
                  endAngle: 0, // Fim (direita)

                  showLabels: false,
                  showTicks: false,

                  ranges: <GaugeRange>[
                    // Faixa Laranja (Progresso)
                    GaugeRange(
                      startValue: 0,
                      endValue: clusterScore,
                      color: Colors.orange.shade400,
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
                  // pointers: <GaugePointer>[
                  //   MarkerPointer(
                  //     value: clusterScore, // Posição do traço
                  //     markerHeight: 18,
                  //     markerWidth: 3,
                  //     markerType: MarkerType.rectangle,
                  //     color: Colors.black,
                  //     enableDragging: false,
                  //   ),
                  // ],

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
                      angle: 90,
                      positionFactor: 0.6,
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
