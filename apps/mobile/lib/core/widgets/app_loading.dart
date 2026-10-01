import 'package:material_ui/material_ui.dart';

/// Standard loading state. Every important async screen must show this
/// (or an inline equivalent) rather than a blank screen — see AGENTS.md §6.
class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
