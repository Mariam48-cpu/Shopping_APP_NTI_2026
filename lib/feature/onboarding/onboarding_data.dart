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
      image:
          'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip',
    ),
    OnboardingData(
      title: "Latest out fit",
      description: "Express your self through the art of the fashionism",
      image:
          'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip',
    ),
  ];
}
