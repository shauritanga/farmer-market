import 'package:fama/core/error/failure.dart';

/// Transient data collected across the name -> phone -> code -> password ->
/// role registration wizard. Distinct from [AuthState]: this is in-progress
/// form data, not a session — it's discarded once the role step hands off
/// to `AuthNotifier.completeRegistration`.
class RegistrationFlowState {
  const RegistrationFlowState({
    this.fullName = '',
    this.phoneNumber = '',
    this.proof = '',
    this.password = '',
    this.developmentCode,
    this.isLoading = false,
    this.error,
  });

  final String fullName;
  final String phoneNumber;

  /// One-time proof returned by `verify-code`, required by `register` to
  /// prove this phone number was just verified.
  final String proof;

  /// Set on the password step, read back on the role step (the final
  /// step, which is the one that actually calls `register`) — kept only
  /// in memory, never persisted to disk.
  final String password;

  /// Set only when the backend is running with no real SMS provider
  /// configured — shown inline so the flow is testable without Beem.
  final String? developmentCode;
  final bool isLoading;
  final Failure? error;

  RegistrationFlowState copyWith({
    String? fullName,
    String? phoneNumber,
    String? proof,
    String? password,
    String? developmentCode,
    bool? isLoading,
    Failure? error,
    bool clearError = false,
  }) {
    return RegistrationFlowState(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      proof: proof ?? this.proof,
      password: password ?? this.password,
      developmentCode: developmentCode ?? this.developmentCode,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
