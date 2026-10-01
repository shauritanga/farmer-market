/// Static copy for one onboarding page. `icon` is a hugeicons icon-data
/// list (e.g. `HugeIcons.strokeRoundedAnalytics01`).
class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final List<List<dynamic>> icon;
}
