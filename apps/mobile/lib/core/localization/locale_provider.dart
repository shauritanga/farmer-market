import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/core/storage/shared_preferences_provider.dart';

const _localeCodeKey = 'app_locale_code';

/// The app defaults to Swahili — see AGENTS.md §13 and the product's
/// primary market. English is available via the settings toggle.
const defaultLocale = Locale('sw');
const supportedAppLocales = [Locale('sw'), Locale('en')];

final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final code = ref.watch(sharedPreferencesProvider).getString(_localeCodeKey);
    final match = supportedAppLocales.where((l) => l.languageCode == code);
    return match.isEmpty ? defaultLocale : match.first;
  }

  Future<void> setLocale(Locale locale) async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(_localeCodeKey, locale.languageCode);
    state = locale;
  }
}
