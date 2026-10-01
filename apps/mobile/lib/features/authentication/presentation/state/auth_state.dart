import 'package:fama/core/error/failure.dart';
import 'package:fama/features/authentication/domain/entities/user.dart';

/// Presentation-specific state for the auth flow. Distinct from the
/// domain [User] entity — this also carries loading/error, which the
/// domain layer has no business knowing about.
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final User user;
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.failure);
  final Failure failure;
}
