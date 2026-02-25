import 'package:flutter/material.dart';
import 'package:mentis_ai/screens/onboarding/models/onboarding_model.dart';
import 'package:mentis_ai/utils/app-colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        32,
        32,
        32,
        120,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item.image,
            height: 300,
            errorBuilder: (
              _,
              __,
              ___,
            ) =>
                const Text("Imagem não encontrada"),
          ),
          const SizedBox(height: 100),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.black900,
                ),
                children: [
                  TextSpan(
                      text: item.text,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'HostGrotesk',
                      )),
                  TextSpan(
                    text: item.highLightedText,
                    style: TextStyle(
                      color: AppColors.supportGreen2,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'HostGrotesk',
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
