import 'package:flutter/material.dart';

class DateNavigator extends StatelessWidget {
  const DateNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.grey, size: 24),
          onPressed: () => {
            //Lógica para voltar dia anterior
          },
        ),
        const Text(
          'HOJE, 20 DE SETEMBRO',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          onPressed: () => {
            //Lógica para implementar dia seguinte
          },
        ),
      ],
    );
  }
}
