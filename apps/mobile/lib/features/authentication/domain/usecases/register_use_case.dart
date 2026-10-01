import 'package:fama/core/utils/result.dart';
import 'package:fama/features/authentication/domain/entities/user.dart';
import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<User>> call({
    required String name,
    required String phoneNumber,
    required String password,
    required String proof,
    required UserRole role,
  }) {
    return _repository.register(
      name: name,
      phoneNumber: phoneNumber,
      password: password,
      proof: proof,
      role: role,
    );
  }
}
