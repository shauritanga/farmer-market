import 'package:fama/core/utils/result.dart';
import 'package:fama/features/authentication/domain/entities/user.dart';
import 'package:fama/features/authentication/domain/entities/user_role.dart';

/// Contract the presentation/domain layers depend on. The data layer
/// implements this — domain never depends on Dio, storage, etc.
abstract interface class AuthRepository {
  Future<Result<User>> login({
    required String phoneNumber,
    required String password,
  });

  Future<Result<void>> logout();

  Future<User?> currentUser();

  /// Step 2 of registration: request a verification code for [phoneNumber].
  /// Returns the dev-mode code when the backend has no real SMS provider
  /// configured (`ONBOARDING_DEV_MODE=true`), else null.
  Future<Result<String?>> sendVerificationCode(String phoneNumber);

  /// Step 3 of registration: confirm the code sent to [phoneNumber].
  /// Returns a one-time proof token to pass to [register].
  Future<Result<String>> verifyCode({
    required String phoneNumber,
    required String code,
  });

  /// Step 5 (final) of registration: create the account — [proof] must be
  /// the token [verifyCode] returned for this phone — and start a session,
  /// same as [login].
  Future<Result<User>> register({
    required String name,
    required String phoneNumber,
    required String password,
    required String proof,
    required UserRole role,
  });
}
