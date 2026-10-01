import 'package:equatable/equatable.dart';

/// Base type for domain-facing errors. Data sources translate
/// infrastructure exceptions (Dio errors, storage errors, etc.) into these
/// so the domain/presentation layers never depend on infrastructure types.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Session expired']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'No cached data available']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong']);
}
