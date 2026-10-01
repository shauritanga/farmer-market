import 'package:hugeicons/hugeicons.dart';

import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/l10n/app_localizations.dart';

List<List<dynamic>> iconForRole(UserRole role) => switch (role) {
  UserRole.farmer => HugeIcons.strokeRoundedLeaf01,
  UserRole.buyer => HugeIcons.strokeRoundedShoppingBag01,
  UserRole.transporter => HugeIcons.strokeRoundedDeliveryTruck01,
};

String labelForRole(UserRole role, AppLocalizations l10n) => switch (role) {
  UserRole.farmer => l10n.roleFarmer,
  UserRole.buyer => l10n.roleBuyer,
  UserRole.transporter => l10n.roleTransporter,
};
