import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Generic read-heavy cache for non-sensitive data (e.g. last known market
/// prices) so screens can show "last updated at ..." while offline, per the
/// offline strategy in docs/architecture/architecture.md.
class LocalCache {
  LocalCache(this._prefs);

  final SharedPreferences _prefs;

  Future<void> putJson(String key, Map<String, dynamic> value) {
    return _prefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> remove(String key) => _prefs.remove(key);
}
