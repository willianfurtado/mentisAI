import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class RecomendationCard extends StatelessWidget {
  final int clusterIndex;

  const RecomendationCard({
    super.key,
    required this.clusterIndex,
  });

  // 1. Função da Mensagem (que já tínhamos)
  String _getRecommendationMessage() {
    switch (clusterIndex) {
      case 0:
        return 'Excelente! Mantenha esse ritmo para preservar sua saúde mental.';
      case 1:
        return 'Você está no caminho certo. Tente adicionar 10 minutos de atividade hoje.';
      case 2:
        return 'Tente fazer uma caminhada de cinco minutos para melhorar seu bem-estar.';
      default:
        return 'Continue monitorando seus dados para receber dicas personalizadas.';
    }
  }

  // 2. A SUA FUNÇÃO DE COR (Inserida aqui)
  Color _getRecommendationColor() {
    if (clusterIndex == 2) return Colors.redAccent; // Risco
    if (clusterIndex == 1) return Colors.orange;    // Moderado
    return AppColors.blue900;                       // Saudável
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 146),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.gray300,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Recomendações',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              _getRecommendationMessage(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // 3. AQUI VOCÊ CHAMA A FUNÇÃO
                color: _getRecommendationColor(), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}