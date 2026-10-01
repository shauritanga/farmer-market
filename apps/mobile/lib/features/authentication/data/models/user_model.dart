import 'package:fama/features/authentication/domain/entities/user.dart';
import 'package:fama/features/authentication/domain/entities/user_role.dart';

/// Wire format returned by the backend. Kept separate from [User] so a
/// backend field rename only touches this file, not the domain layer.
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      // Backend/Prisma roles are upper-case ("FARMER"); Dart enum names
      // follow lowerCamelCase convention (UserRole.farmer.name == "farmer").
      role: UserRole.values.byName((json['role'] as String).toLowerCase()),
    );
  }

  final String id;
  final String name;
  final String phoneNumber;
  final UserRole role;

  User toEntity() {
    return User(id: id, name: name, phoneNumber: phoneNumber, role: role);
  }
}
