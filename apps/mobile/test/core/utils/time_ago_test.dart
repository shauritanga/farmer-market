import 'package:flutter_test/flutter_test.dart';

import 'package:fama/core/utils/time_ago.dart';
import 'package:fama/l10n/app_localizations_en.dart';
import 'package:fama/l10n/app_localizations_sw.dart';

void main() {
  final en = AppLocalizationsEn();
  final sw = AppLocalizationsSw();
  final now = DateTime.utc(2026, 9, 28, 12, 0);

  group('formatUpdatedAgo', () {
    test('says just now within the first minute', () {
      expect(
        formatUpdatedAgo(
          now.subtract(const Duration(seconds: 30)),
          en,
          now: now,
        ),
        'Updated just now',
      );
    });

    test('says minutes ago within the first hour', () {
      expect(
        formatUpdatedAgo(
          now.subtract(const Duration(minutes: 3)),
          en,
          now: now,
        ),
        'Updated 3 min ago',
      );
    });

    test('says hours ago within the first day', () {
      expect(
        formatUpdatedAgo(now.subtract(const Duration(hours: 5)), en, now: now),
        'Updated 5 hr ago',
      );
    });

    test('says days ago after a day', () {
      expect(
        formatUpdatedAgo(now.subtract(const Duration(days: 2)), en, now: now),
        'Updated 2 days ago',
      );
    });

    test('treats future timestamps as just now', () {
      expect(
        formatUpdatedAgo(now.add(const Duration(minutes: 10)), en, now: now),
        'Updated just now',
      );
    });

    test('localizes to Swahili', () {
      expect(
        formatUpdatedAgo(
          now.subtract(const Duration(minutes: 3)),
          sw,
          now: now,
        ),
        'Imesasishwa dakika 3 zilizopita',
      );
    });
  });
}
