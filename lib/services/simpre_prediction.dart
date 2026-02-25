import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';

class SimplePredictionService {
  List<List<double>>? _centroids;

  Future<void> loadModel() async {
    final String response = await rootBundle.loadString('assets/kmeans_model.json');
    final data = json.decode(response);
    _centroids = (data['centroids'] as List)
        .map((e) => List<double>.from(e.map((v) => v.toDouble())))
        .toList();
  }

  int predict(List<double> input) {
    if (_centroids == null) return -1;

    int bestCluster = 0;
    double minDistance = double.infinity;

    for (int i = 0; i < _centroids!.length; i++) {
      double distance = 0;
      for (int j = 0; j < input.length; j++) {
        distance += pow(input[j] - _centroids![i][j], 2);
      }
      distance = sqrt(distance);

      if (distance < minDistance) {
        minDistance = distance;
        bestCluster = i;
      }
    }
    return bestCluster;
  }
}