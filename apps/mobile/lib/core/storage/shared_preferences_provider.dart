import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Overridden in `bootstrap()` with the resolved instance before `runApp` —
/// see app/bootstrap/bootstrap.dart. Never read before that override runs.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in bootstrap()',
  );
});
