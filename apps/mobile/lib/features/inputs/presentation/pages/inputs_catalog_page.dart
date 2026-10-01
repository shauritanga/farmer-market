import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/features/inputs/presentation/providers/inputs_provider.dart';
import 'package:fama/features/inputs/presentation/widgets/agro_input_card.dart';
import 'package:fama/l10n/app_localizations.dart';

/// The farm inputs catalog: seeds, fertilizer, pesticides and more that
/// a farmer can browse and order.
class InputsCatalogPage extends ConsumerWidget {
  const InputsCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final inputsAsync = ref.watch(inputsCatalogProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.inputsTitle),
        actions: [
          IconButton(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedInvoice01, size: 22.sp),
            onPressed: () => context.push(myInputOrdersPath),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(inputsCatalogProvider.future),
        child: inputsAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.inputsLoadError,
                onRetry: () => ref.invalidate(inputsCatalogProvider),
              ),
            ],
          ),
          data: (inputs) {
            if (inputs.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 80.h),
                  AppEmptyState(message: l10n.inputsEmpty),
                ],
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: inputs.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) =>
                  AgroInputCard(input: inputs[index]),
            );
          },
        ),
      ),
    );
  }
}
