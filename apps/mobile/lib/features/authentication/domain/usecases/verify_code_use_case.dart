import 'package:fama/core/utils/result.dart';
import 'package:fama/features/authentication/domain/repositories/auth_repository.dart';

class VerifyCodeUseCase {
  const VerifyCodeUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<String>> call({
    required String phoneNumber,
    required String code,
  }) {
    return _repository.verifyCode(phoneNumber: phoneNumber, code: code);
  }
}
