class OnboardingData {
  final String title;
  final String description;
  final String image;
  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingData> dataOnboarding() {
  return [
    OnboardingData(
      title: "Discover Trends",
      description: "Now we are here to provide variety of the best fashion",
      image: 'assets/image/onboarding_1.png',
    ),
    OnboardingData(
      title: "Latest out fit",
      description: "Express your self through the art of the fashionism",
      image: 'assets/image/onboarding_2.png',
    ),
  ];
}
