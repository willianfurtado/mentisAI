import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sobre", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120, 
                width: 120,
                child: Image.asset(
                  'assets/images/mentis.png', 
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              
              const Text(
                "Mentis AI",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Versão 1.0.0",
                style: TextStyle(color: Colors.grey),
              ),
              
              const SizedBox(height: 30),
              
              const Text(
                "O Mentis AI é o seu assistente inteligente para monitoramento de saúde mental e bem-estar físico. Utilizamos dados para fornecer insights valiosos para o seu dia a dia.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
              ),
              
              const SizedBox(height: 40),

              // Créditos
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Text(
                      "Desenvolvido por",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16,
                        color: Colors.black87
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Willian Jorge",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Alexandre Henrique",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              const Text("© 2026 Mentis AI Inc.", style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}