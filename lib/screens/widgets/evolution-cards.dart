import 'package:flutter/material.dart';

class EvolutionCards extends StatelessWidget {
  final String title;
  final IconData icon;
  
  const EvolutionCards({
    super.key, 
    required this.title, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      width: 170,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),

      child: Column(
        children: [
          Row(
            children: [
              //Icone da seção
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon, 
                  color: Colors.white,
                  size: 30,
                ),
              ),

              Container(
                height: 23,
                width: 23,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.blue,
                    size: 30),
                  onPressed: () => {
                    //Implementar lógica de ir para a página 
                  }, 
                ),
              ),
            ],
          ),
          Text(
            title, 
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}