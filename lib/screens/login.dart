import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Logo MentisAI
                Image.asset(
                  'assets/images/mentis.png',
                  height: 400.0,
                  width: 400.0,
                ),

                Text(
                  'Conecte-se com a sua saúde mental, todos os dias',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 40),

                // 7. Botão Entrar com o Google
                SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Lógica de login com Google
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.black900,
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: AppColors.supportGreen2,
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    icon: SvgPicture.asset(
                      'assets/images/google-icon.svg',
                      height: 24.0,
                    ),
                    label: const Text(
                      'Entrar com o Google',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já tem uma conta?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Acessar conta',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.supportGreen2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
