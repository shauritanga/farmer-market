import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fama/app/app.dart';
import 'package:fama/core/storage/shared_preferences_provider.dart';

/// Single entry point for app startup so `main.dart` stays a one-liner.
/// Add crash reporting / env loading / dependency warmup here as they're
/// introduced — keep it a thin orchestrator, not a dumping ground.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const FamaApp(),
    ),
  );
}
