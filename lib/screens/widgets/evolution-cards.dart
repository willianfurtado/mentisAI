import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class EvolutionCards extends StatelessWidget {
  final String title;
  final IconData icon;

  const EvolutionCards({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 170,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Icone da seção
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.blue900,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),

              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.blue700),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    color: AppColors.blue700,
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => {
                    // Implementar lógica de ir para a página
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blue900,
            ),
          ),
        ],
      ),
    );
  }
}
