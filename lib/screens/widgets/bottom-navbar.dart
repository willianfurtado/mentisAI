import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Métricas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Triagem',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue, // Cor do ícone selecionado
      unselectedItemColor: Colors.grey, // Cor dos ícones não selecionados
      backgroundColor: Colors.white,
      onTap: onTap,
    );
  }
}
