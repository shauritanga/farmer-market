import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/core/localization/locale_provider.dart';
import 'package:fama/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, size: 22.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.settingsTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settingsLanguageLabel,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 12.h),
            SegmentedButton<Locale>(
              segments: const [
                ButtonSegment(value: Locale('sw'), label: Text('Kiswahili')),
                ButtonSegment(value: Locale('en'), label: Text('English')),
              ],
              selected: {locale},
              onSelectionChanged: (selection) {
                ref
                    .read(localeNotifierProvider.notifier)
                    .setLocale(selection.first);
              },
            ),
          ],
        ),
      ),
    );
  }
}
