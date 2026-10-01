import 'package:dio/dio.dart';

import 'package:fama/core/error/failure.dart';
import 'package:fama/core/storage/token_storage.dart';
import 'package:fama/core/utils/result.dart';
import 'package:fama/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fama/features/authentication/data/models/user_model.dart';
import 'package:fama/features/authentication/domain/entities/user.dart';
import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorage tokenStorage,
  }) : _remoteDataSource = remoteDataSource,
       _tokenStorage = tokenStorage;

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<Result<User>> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(
        phoneNumber: phoneNumber,
        password: password,
      );
      return Result.success(await _persistSession(result));
    } on DioException catch (e) {
      return Result.failure(_mapDioError(e));
    }
  }

  @override
  Future<Result<User>> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String proof,
    required UserRole role,
  }) async {
    try {
      final result = await _remoteDataSource.register(
        name: name,
        phoneNumber: phoneNumber,
        password: password,
        proof: proof,
        // Backend/Prisma roles are upper-case ("FARMER").
        role: role.name.toUpperCase(),
      );
      return Result.success(await _persistSession(result));
    } on DioException catch (e) {
      return Result.failure(_mapDioError(e));
    }
  }

  @override
  Future<Result<String?>> sendVerificationCode(String phoneNumber) async {
    try {
      final developmentCode = await _remoteDataSource.sendVerificationCode(
        phoneNumber,
      );
      return Result.success(developmentCode);
    } on DioException catch (e) {
      return Result.failure(_mapDioError(e));
    }
  }

  @override
  Future<Result<String>> verifyCode({
    required String phoneNumber,
    required String code,
  }) async {
    try {
      final proof = await _remoteDataSource.verifyCode(
        phoneNumber: phoneNumber,
        code: code,
      );
      return Result.success(proof);
    } on DioException catch (e) {
      return Result.failure(_mapDioError(e));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _tokenStorage.clear();
      return const Result.success(null);
    } on DioException catch (e) {
      // Clear local tokens regardless — the user must not remain
      // "logged in" locally just because the server call failed.
      await _tokenStorage.clear();
      return Result.failure(_mapDioError(e));
    }
  }

  @override
  Future<User?> currentUser() async {
    // A real implementation would decode/validate the stored access token
    // or call `/auth/me`. Left minimal for the initial scaffold.
    final token = await _tokenStorage.readAccessToken();
    return token == null ? null : null;
  }

  Future<User> _persistSession(
    ({UserModel user, String accessToken, String refreshToken}) session,
  ) async {
    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    return session.user.toEntity();
  }

  Failure _mapDioError(DioException e) {
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
}
