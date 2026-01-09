import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class PredictionService {
  List<List<double>>? _centroids;

  // --- VALORES DO ROBUST SCALER (COPIADOS DO SEU COLAB) ---
  // Ordem: [0] = passos, [1] = calorias
  final List<double> _medianas = [5217.0, 1761.64];
  final List<double> _escalas = [4852.0, 311.89];

  Future<void> loadModel() async {
    try {
      final String response = await rootBundle.loadString('assets/models/kmeans_model.json');
      final data = json.decode(response);
      
      _centroids = (data['centroids'] as List)
          .map((cluster) => List<double>.from(cluster.map((v) => v.toDouble())))
          .toList();
          
      print("✅ Modelo e Scaler configurados com sucesso!");
    } catch (e) {
      print("❌ Erro ao carregar o modelo: $e");
    }
  }

  int predict(List<double> input) {
    if (_centroids == null) return -1;

    // 1. NORMALIZAÇÃO ROBUSTA (Igual ao Python)
    List<double> inputScaled = [];
    for (int i = 0; i < input.length; i++) {
      // Fórmula: (Valor - Mediana) / IQR
      double scaledValue = (input[i] - _medianas[i]) / _escalas[i];
      inputScaled.add(scaledValue);
    }

    // 2. CÁLCULO DE DISTÂNCIA (K-Means)
    int clusterVencedor = 0;
    double menorDistancia = double.infinity;

    for (int i = 0; i < _centroids!.length; i++) {
      double distancia = _calcularDistanciaEuclidiana(inputScaled, _centroids![i]);

      if (distancia < menorDistancia) {
        menorDistancia = distancia;
        clusterVencedor = i;
      }
    }

    return clusterVencedor;
  }

  double _calcularDistanciaEuclidiana(List<double> p1, List<double> p2) {
    double soma = 0;
    for (int i = 0; i < p1.length; i++) {
      soma += pow(p1[i] - p2[i], 2);
    }
    return sqrt(soma);
  }
}