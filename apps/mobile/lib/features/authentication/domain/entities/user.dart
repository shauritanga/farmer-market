import 'package:equatable/equatable.dart';

import 'package:fama/features/authentication/domain/entities/user_role.dart';

/// The authenticated identity. Only what the domain/presentation layers
/// need — never the raw API DTO (see AGENTS.md §7).
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final UserRole role;

  @override
  List<Object?> get props => [id, name, phoneNumber, role];
}
