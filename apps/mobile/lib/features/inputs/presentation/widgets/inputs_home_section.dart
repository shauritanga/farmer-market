import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/features/inputs/presentation/providers/inputs_provider.dart';
import 'package:fama/features/inputs/presentation/widgets/agro_input_card.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Home tab preview: the first inputs in the catalog (up to 3) with a
/// link to the full catalog. Stays quiet while loading or when the
/// catalog is empty — the market section above is the primary content.
class InputsHomeSection extends ConsumerWidget {
  const InputsHomeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final inputsAsync = ref.watch(inputsCatalogProvider);

    return inputsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, _) => const SizedBox.shrink(),
      data: (inputs) {
        if (inputs.isEmpty) return const SizedBox.shrink();
        final preview = inputs.take(3).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              l10n.inputsSectionTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 12.h),
            for (final input in preview)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: AgroInputCard(input: input),
              ),
            Center(
              child: TextButton(
                onPressed: () => context.push(inputsPath),
                child: Text(l10n.inputsViewAll),
              ),
            ),
          ],
        );
      },
    );
  }
}
