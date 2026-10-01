/// API base URL, overridable per build via:
///   flutter run --dart-define=API_BASE_URL=https://api.example.com
class ApiConfig {
  ApiConfig._();

  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );
}
