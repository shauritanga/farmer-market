import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/features/buyers/presentation/providers/buyer_demand_provider.dart';
import 'package:fama/features/buyers/presentation/widgets/buyer_demand_card.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Every open buyer request, newest first. Farmers browse this to
/// discover genuine demand for their produce.
class BuyerDemandsPage extends ConsumerWidget {
  const BuyerDemandsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final demandsAsync = ref.watch(openBuyerDemandsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.buyerDemandsTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(openBuyerDemandsProvider.future),
        child: demandsAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.buyerDemandsLoadError,
                onRetry: () => ref.invalidate(openBuyerDemandsProvider),
              ),
            ],
          ),
          data: (demands) {
            if (demands.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 80.h),
                  AppEmptyState(message: l10n.buyerDemandsEmpty),
                ],
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: demands.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) =>
                  BuyerDemandCard(demand: demands[index]),
            );
          },
        ),
      ),
    );
  }
}
