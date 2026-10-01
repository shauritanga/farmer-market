import 'package:flutter/foundation.dart';

/// A bare `ChangeNotifier` used as GoRouter's `refreshListenable`. Call
/// [refresh] (via `ref.listen(...)` in the provider that builds the router)
/// whenever a value the `redirect` logic depends on changes — GoRouter has
/// no native Riverpod awareness otherwise.
class RouterRefreshListenable extends ChangeNotifier {
  void refresh() => notifyListeners();
}
