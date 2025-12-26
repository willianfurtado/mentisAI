import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/user_profile/user_settings.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Editar perfil',
        'icon': Icons.person_outline,
        'route': const UserSettings()
      },
      {'title': 'Permissões', 'icon': Icons.verified_user_outlined},
      {'title': 'Sobre', 'icon': Icons.help_outline},
      {'title': 'Log out', 'icon': Icons.logout},
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text('Configurações',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              //Seção do Avatar e nome do usuário
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFE0E0E0),
              ),
              const SizedBox(height: 16),
              const Text(
                'Willian Jorge Sousa Furtado',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black400,
                ),
              ),

              const SizedBox(height: 24),

              //Lista de cards clicáveis
              for (var item in menuItems)
                _buildMenuCard(context,
                    icon: item['icon'], title: item['title'], onTap: () {
                  if (item['route'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item['route']),
                    );
                  } else {
                    print("Rota ainda não disponível");
                  }
                }),

              const SizedBox(height: 40),

              const SizedBox(
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMenuCard(BuildContext context,
    {required IconData icon,
    required String title,
    required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.black87),
          ],
        ),
      ),
    ),
  );
}
