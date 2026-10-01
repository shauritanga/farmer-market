import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/authentication/presentation/providers/registration_flow_provider.dart';
import 'package:fama/features/authentication/presentation/state/auth_state.dart';
import 'package:fama/features/authentication/presentation/widgets/registration_step_scaffold.dart';
import 'package:fama/features/authentication/presentation/widgets/role_field.dart';
import 'package:fama/features/authentication/presentation/widgets/role_picker_sheet.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Step 5 (final) of registration: pick a role — same page layout as every
/// other step (see [RegistrationStepScaffold]), but the field itself opens
/// [RolePickerSheet] instead of a keyboard. Submitting here is what
/// actually creates the account; the router's redirect takes over from
/// there and lands the now-authenticated user on their home screen.
class RegisterRolePage extends ConsumerStatefulWidget {
  const RegisterRolePage({super.key});

  @override
  ConsumerState<RegisterRolePage> createState() => _RegisterRolePageState();
}

class _RegisterRolePageState extends ConsumerState<RegisterRolePage> {
  UserRole? _selectedRole;
  String? _fieldError;

  Future<void> _pickRole() async {
    final picked = await RolePickerSheet.show(context, selected: _selectedRole);
    if (picked != null) {
      setState(() {
        _selectedRole = picked;
        _fieldError = null;
      });
    }
  }

  void _submit() {
    final role = _selectedRole;
    if (role == null) {
      setState(() => _fieldError = AppLocalizations.of(context)!.roleRequired);
      return;
    }

    final flow = ref.read(registrationFlowProvider);
    ref
        .read(authNotifierProvider.notifier)
        .completeRegistration(
          name: flow.fullName,
          phoneNumber: flow.phoneNumber,
          password: flow.password,
          proof: flow.proof,
          role: role,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;
    final errorMessage = authState is AuthError
        ? authState.failure.message
        : null;

    return RegistrationStepScaffold(
      title: l10n.roleSheetTitle,
      subtitle: l10n.roleSheetSubtitle,
      field: RoleField(
        role: _selectedRole,
        onTap: _pickRole,
        errorText: _fieldError,
      ),
      buttonLabel: l10n.registerCreateAccountButton,
      isLoading: isLoading,
      errorMessage: errorMessage,
      onSubmit: _submit,
    );
  }
}
