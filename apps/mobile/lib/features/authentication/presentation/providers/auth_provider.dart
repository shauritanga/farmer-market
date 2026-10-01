import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/core/network/api_client.dart';
import 'package:fama/core/network/api_config.dart';
import 'package:fama/core/storage/token_storage.dart';
import 'package:fama/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fama/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:fama/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fama/features/authentication/domain/usecases/login_use_case.dart';
import 'package:fama/features/authentication/domain/usecases/register_use_case.dart';
import 'package:fama/features/authentication/domain/usecases/send_verification_code_use_case.dart';
import 'package:fama/features/authentication/domain/usecases/verify_code_use_case.dart';
import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/features/authentication/presentation/state/auth_state.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    baseUrl: ApiConfig.baseUrl,
    tokenStorage: ref.watch(tokenStorageProvider),
  );
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(apiClientProvider).dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final sendVerificationCodeUseCaseProvider =
    Provider<SendVerificationCodeUseCase>((ref) {
      return SendVerificationCodeUseCase(ref.watch(authRepositoryProvider));
    });

final verifyCodeUseCaseProvider = Provider<VerifyCodeUseCase>((ref) {
  return VerifyCodeUseCase(ref.watch(authRepositoryProvider));
});

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthInitial();

  Future<void> login({
    required String phoneNumber,
    required String password,
  }) async {
    state = const AuthLoading();
    final result = await ref
        .read(loginUseCaseProvider)
        .call(phoneNumber: phoneNumber, password: password);

    state = result.when(success: AuthAuthenticated.new, failure: AuthError.new);
  }

  /// Final step of registration — creates the account and starts a
  /// session, same end state as [login].
  Future<void> completeRegistration({
    required String name,
    required String phoneNumber,
    required String password,
    required String proof,
    required UserRole role,
  }) async {
    state = const AuthLoading();
    final result = await ref
        .read(registerUseCaseProvider)
        .call(
          name: name,
          phoneNumber: phoneNumber,
          password: password,
          proof: proof,
          role: role,
        );

    state = result.when(success: AuthAuthenticated.new, failure: AuthError.new);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthUnauthenticated();
  }
}
