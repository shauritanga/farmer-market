import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/localization/locale_provider.dart';
import 'package:fama/core/theme/app_theme.dart';
import 'package:fama/l10n/app_localizations.dart';

class FamaApp extends ConsumerWidget {
  const FamaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeNotifierProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Android can report a transient zero physical size for the first
      // frame or two on cold start, which would make every `.sp`/`.w`/`.h`
      // call briefly return 0 — harmless for a plain Text, but fatal for
      // EditableText's strut-style assertion (fontSize must be > 0). This
      // defers the first frame until a real, non-zero size is available.
      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Fama',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.system,
          locale: locale,
          // `GlobalMaterialLocalizations` resolves from `material_ui` and
          // `GlobalCupertinoLocalizations` from its sibling `cupertino_ui`
          // package — NOT from `flutter_localizations`, whose versions of
          // both are different, incompatible types (same gotcha as
          // ThemeData; see core/theme/app_theme.dart's doc comment). Only
          // `GlobalWidgetsLocalizations` genuinely comes from
          // `flutter_localizations` here.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedAppLocales,
          routerConfig: router,
        );
      },
    );
  }
}
