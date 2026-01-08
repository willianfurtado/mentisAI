import 'package:flutter/material.dart';
import 'package:mentis_ai/utils/app-colors.dart'; 

class EvolutionCards extends StatelessWidget {
  final String title;
  final Widget iconWidget;
  
  final String? value; 
  final String? unit;
  final VoidCallback? onTap;

  const EvolutionCards({
    super.key,
    required this.title,
    required this.iconWidget,
    this.value,
    this.unit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20), 
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blue800, 
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone
            SizedBox(
              height: 35, 
              width: 35, 
              child: iconWidget
            ),
            
            const SizedBox(height: 10),
            
            // Título
            Text(
              title,
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 14, 
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
            
            
            if (value != null) ...[
              const SizedBox(height: 6),
              Text(
                value!,
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
            
            if (unit != null)
              Text(
                unit!,
                style: const TextStyle(
                  color: Colors.white70, 
                  fontSize: 12
                ),
              ),
          ],
        ),
      ),
    );
  }
}