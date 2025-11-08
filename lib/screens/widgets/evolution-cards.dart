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