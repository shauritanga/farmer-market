import 'package:dio/dio.dart';

import 'package:fama/core/storage/token_storage.dart';

/// Thin wrapper around [Dio] shared by every feature's remote data sources.
///
/// Kept in `core/network` because it is a genuine cross-feature concern:
/// base URL, auth header injection, and timeouts apply to every request.
class ApiClient {
  ApiClient({required String baseUrl, required TokenStorage tokenStorage})
    : _tokenStorage = tokenStorage,
      dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.readAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  final Dio dio;
  final TokenStorage _tokenStorage;
}
