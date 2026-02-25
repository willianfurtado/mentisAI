import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/onboarding/models/onboarding_model.dart';
import 'package:mentis_ai/screens/onboarding/widgets/onboarding_page.dart';
import 'package:mentis_ai/screens/login/login.dart';
import 'package:mentis_ai/utils/app-colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> onboardingPages = [
    OnboardingItem(
      image: 'assets/images/onboarding1.png',
      text: 'Sincronize seus dados de ',
      highLightedText: 'saúde e sono automaticamente',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.png',
      text: 'Nosso app analisa seus padrões para identificar sinais de ',
      highLightedText: 'desgaste mental',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.png',
      text: 'Receba recomendações ',
      highLightedText: 'personalizadas para o seu dia a dia',
    ),
    OnboardingItem(
      image: 'assets/images/mentis.png',
      text: 'Pronto(a) para dar o ',
      highLightedText: 'primeiro passo?',
      isLastPage: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const Login(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentIndex == onboardingPages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          /// BOTÃO PULAR
          Positioned(
            top: 60,
            right: 24,
            child: TextButton(
              onPressed: goToLogin,
              child: const Text(
                "Pular",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF24966D),
                ),
              ),
            ),
          ),

          /// PAGEVIEW COM FADE
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingPages.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;

                  if (_pageController.position.haveDimensions) {
                    value = (_pageController.page! - index);
                    value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                  }

                  return Opacity(opacity: value, child: child);
                },
                child: OnboardingPage(item: onboardingPages[index]),
              );
            },
          ),

          /// INDICADOR + BOTÃO FINAL
          Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: Column(
              children: [
                /// INDICADOR ANIMADO
                if (!isLastPage)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingPages.length,
                      (index) => buildDot(index),
                    ),
                  )

                /// BOTÃO FINAL
                else
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF24966D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: goToLogin,
                      child: const Text(
                        "Começar  →",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// INDICADOR COM EXPANSÃO ANIMADA
  Widget buildDot(int index) {
    bool active = _currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: active ? 24 : 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF24966D) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
