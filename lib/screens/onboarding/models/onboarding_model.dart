class OnboardingItem {
  final String text;
  final String image;
  final String highLightedText;
  final bool isLastPage;

  OnboardingItem({
    required this.image,
    required this.text,
    this.highLightedText = "",
    this.isLastPage = false,
  });
} 