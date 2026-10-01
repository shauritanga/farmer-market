import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fama/core/storage/shared_preferences_provider.dart';

const _hasCompletedOnboardingKey = 'has_completed_onboarding';

class OnboardingLocalDataSource {
  const OnboardingLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  bool get hasCompletedOnboarding =>
      _prefs.getBool(_hasCompletedOnboardingKey) ?? false;

  Future<void> completeOnboarding() =>
      _prefs.setBool(_hasCompletedOnboardingKey, true);
}

final onboardingLocalDataSourceProvider = Provider<OnboardingLocalDataSource>((
  ref,
) {
  return OnboardingLocalDataSource(ref.watch(sharedPreferencesProvider));
});
