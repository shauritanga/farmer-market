import 'package:fama/core/utils/result.dart';
import 'package:fama/features/authentication/domain/repositories/auth_repository.dart';

class SendVerificationCodeUseCase {
  const SendVerificationCodeUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<String?>> call(String phoneNumber) {
    return _repository.sendVerificationCode(phoneNumber);
  }
}
