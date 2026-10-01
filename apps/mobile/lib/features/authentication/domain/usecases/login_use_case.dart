import 'package:fama/core/utils/result.dart';
import 'package:fama/features/authentication/domain/entities/user.dart';
import 'package:fama/features/authentication/domain/repositories/auth_repository.dart';

/// A meaningful business action, not a generic "handle screen" call
/// (see AGENTS.md §8).
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<User>> call({
    required String phoneNumber,
    required String password,
  }) {
    return _repository.login(phoneNumber: phoneNumber, password: password);
  }
}
