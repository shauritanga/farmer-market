import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/onboarding/data/onboarding_local_data_source.dart';

final onboardingNotifierProvider = NotifierProvider<OnboardingNotifier, bool>(
  OnboardingNotifier.new,
);

class OnboardingNotifier extends Notifier<bool> {
  @override
  bool build() =>
      ref.watch(onboardingLocalDataSourceProvider).hasCompletedOnboarding;

  Future<void> completeOnboarding() async {
    await ref.read(onboardingLocalDataSourceProvider).completeOnboarding();
    state = true;
  }
}
