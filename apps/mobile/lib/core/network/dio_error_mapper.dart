import 'package:dio/dio.dart';

import 'package:fama/core/error/failure.dart';

/// Shared `DioException` -> `Failure` mapping so every repository's
/// try/catch doesn't reinvent this. See
/// `features/authentication/data/repositories/auth_repository_impl.dart`
/// for the (slightly older, not-yet-migrated) version of this same logic.
Failure mapDioError(DioException e) {
  if (e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout) {
    return const NetworkFailure();
  }
  if (e.response?.statusCode == 401) {
    return const UnauthorizedFailure();
  }
  final message = (e.response?.data is Map)
      ? (e.response?.data['message']?.toString())
      : null;
  return ServerFailure(
    message ?? 'Something went wrong',
    statusCode: e.response?.statusCode,
  );
}
