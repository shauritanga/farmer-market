import 'package:dio/dio.dart';

import 'package:fama/features/authentication/data/models/user_model.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<({UserModel user, String accessToken, String refreshToken})> login({
    required String phoneNumber,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'phoneNumber': phoneNumber, 'password': password},
    );
    return _parseSession(response.data as Map<String, dynamic>);
  }

  Future<({UserModel user, String accessToken, String refreshToken})> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String proof,
    required String role,
  }) async {
    final response = await _dio.post(
      '/auth/register',
      data: {
        'name': name,
        'phoneNumber': phoneNumber,
        'password': password,
        'proof': proof,
        'role': role,
      },
    );
    return _parseSession(response.data as Map<String, dynamic>);
  }

  /// Returns the dev-mode code when the backend is running with
  /// `ONBOARDING_DEV_MODE=true` (no real SMS sent) — null in production.
  Future<String?> sendVerificationCode(String phoneNumber) async {
    final response = await _dio.post(
      '/auth/send-code',
      data: {'phoneNumber': phoneNumber},
    );
    return (response.data as Map<String, dynamic>)['developmentCode']
        as String?;
  }

  /// Returns the one-time proof token to pass to [register].
  Future<String> verifyCode({
    required String phoneNumber,
    required String code,
  }) async {
    final response = await _dio.post(
      '/auth/verify-code',
      data: {'phoneNumber': phoneNumber, 'code': code},
    );
    return (response.data as Map<String, dynamic>)['proof'] as String;
  }

  Future<void> logout() => _dio.post('/auth/logout');

  ({UserModel user, String accessToken, String refreshToken}) _parseSession(
    Map<String, dynamic> data,
  ) {
    return (
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}
