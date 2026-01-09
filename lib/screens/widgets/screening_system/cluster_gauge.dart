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
                  maximum: 100, 
                  startAngle: 180,
                  endAngle: 0,

                  showLabels: false,
                  showTicks: false,

                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 0,
                      endValue: clusterScore,
                      color: Colors.orange.shade400,
                      startWidth: 25,
                      endWidth: 25,
                    ),
                    GaugeRange(
                      startValue: clusterScore,
                      endValue: 100,
                      color: Colors.grey.shade300,
                      startWidth: 25,
                      endWidth: 25,
                    ),
                  ],

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

                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        clusterClassification,
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
