import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class EvolutionCards extends StatelessWidget {
  final String title;
  final Widget iconWidget;

  const EvolutionCards(
      {super.key, required this.title, required this.iconWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 170,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(26.0),
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
                decoration: const BoxDecoration(
                  color: AppColors.blue900,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: iconWidget,
                ),
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
                    Navigator.pushNamed(context, '/evolution-system-steps'),
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
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
