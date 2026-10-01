import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fama/app/app.dart';
import 'package:fama/core/storage/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Onboarding has intentionally infinite looping animations (drifting
// particles, a pulsing "Get Started" button), so `pumpAndSettle` — which
// waits until no frames are scheduled — never returns. Use a bounded
// number of fixed-duration pumps instead.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App boots to onboarding first, defaulting to Swahili', (
    WidgetTester tester,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const FamaApp(),
      ),
    );
    await _settle(tester);

    // Swahili is the default locale — see core/localization/locale_provider.dart.
    expect(find.text('Fahamu Soko Lako'), findsOneWidget);
    expect(find.text('Ruka'), findsOneWidget);
  });

  testWidgets('Completing onboarding navigates to login', (
    WidgetTester tester,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const FamaApp(),
      ),
    );
    await _settle(tester);

    await tester.tap(find.text('Ruka'));
    await _settle(tester);

    expect(find.text('Ingia'), findsWidgets);
  });
}
