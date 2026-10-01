import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/authentication/presentation/state/registration_flow_state.dart';

final registrationFlowProvider =
    NotifierProvider<RegistrationFlowNotifier, RegistrationFlowState>(
      RegistrationFlowNotifier.new,
    );

class RegistrationFlowNotifier extends Notifier<RegistrationFlowState> {
  @override
  RegistrationFlowState build() => const RegistrationFlowState();

  void setFullName(String name) {
    state = state.copyWith(fullName: name);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  /// Requests a verification code for [phoneNumber]. Returns whether it
  /// succeeded so the page can decide whether to navigate on.
  Future<bool> sendCode(String phoneNumber) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref
        .read(sendVerificationCodeUseCaseProvider)
        .call(phoneNumber);

    return result.when(
      success: (developmentCode) {
        state = state.copyWith(
          isLoading: false,
          phoneNumber: phoneNumber,
          developmentCode: developmentCode,
          clearError: true,
        );
        return true;
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false, error: failure);
        return false;
      },
    );
  }

  Future<bool> verifyCode(String code) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref
        .read(verifyCodeUseCaseProvider)
        .call(phoneNumber: state.phoneNumber, code: code);

    return result.when(
      success: (proof) {
        state = state.copyWith(
          isLoading: false,
          proof: proof,
          clearError: true,
        );
        return true;
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false, error: failure);
        return false;
      },
    );
  }
}
