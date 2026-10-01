import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fama/core/widgets/status_badge.dart';
import 'package:fama/features/inputs/domain/entities/agro_input.dart';
import 'package:fama/features/inputs/presentation/widgets/order_input_dialog.dart';
import 'package:fama/l10n/app_localizations.dart';

/// One catalog row: what the input is, what it costs, whether it's in
/// stock — and the order action.
class AgroInputCard extends ConsumerWidget {
  const AgroInputCard({super.key, required this.input});

  final AgroInput input;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final subtitle = [
      if (input.supplierName != null) input.supplierName!,
      'per ${input.unit}',
    ].join(' · ');

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(input.name, style: textTheme.titleMedium)),
                StatusBadge(label: input.category, tone: StatusTone.neutral),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (input.description != null) ...[
              SizedBox(height: 8.h),
              Text(input.description!, style: textTheme.bodyMedium),
            ],
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${input.currency} ${input.price.toStringAsFixed(0)}',
                  style: textTheme.headlineSmall,
                ),
                if (input.inStock)
                  FilledButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => OrderInputDialog(input: input),
                    ),
                    child: Text(l10n.inputsOrderButton),
                  )
                else
                  StatusBadge(
                    label: l10n.inputsOutOfStock,
                    tone: StatusTone.error,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
