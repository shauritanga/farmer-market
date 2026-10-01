import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// FlexColorScheme-based theme, seeded from the agricultural-green brand
/// color. Sub-theme radii/elevations follow the same restrained, low-shadow
/// technique as the sibling Safina app (12px control radius, 16px card
/// radius, filled outlined inputs, flat elevated buttons) — see AGENTS.md
/// §4 UI direction for why: no gradients, no heavy shadows, no glassmorphism.
///
/// [light]/[dark] call `.sp` (ScreenUtil) for text sizes, so they must only
/// ever be built inside `ScreenUtilInit`'s `builder` — see app/app.dart.
class AppTheme {
  AppTheme._();

  static const seed = Color(0xFF2E7D32);

  static const _subThemes = FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    useMaterial3Typography: true,
    defaultRadius: 12,
    elevatedButtonRadius: 12,
    elevatedButtonElevation: 0,
    outlinedButtonRadius: 12,
    textButtonRadius: 12,
    filledButtonRadius: 12,
    inputDecoratorRadius: 12,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorUnfocusedHasBorder: false,
    cardRadius: 16,
    cardElevation: 0,
    dialogRadius: 24,
    bottomSheetRadius: 24,
    popupMenuRadius: 12,
    chipRadius: 8,
    appBarCenterTitle: false,
    appBarScrolledUnderElevation: 1,
    navigationBarElevation: 1,
  );

  static ThemeData light() {
    return FlexColorScheme.light(
      colors: FlexSchemeColor.from(primary: seed),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 7,
      keyColors: const FlexKeyColors(),
      subThemesData: _subThemes,
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    ).toTheme.copyWith(textTheme: _textTheme(Brightness.light));
  }

  static ThemeData dark() {
    return FlexColorScheme.dark(
      colors: FlexSchemeColor.from(primary: seed),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 13,
      keyColors: const FlexKeyColors(),
      subThemesData: _subThemes,
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    ).toTheme.copyWith(textTheme: _textTheme(Brightness.dark));
  }

  static TextTheme _textTheme(Brightness brightness) {
    final onSurface = brightness == Brightness.light
        ? const Color(0xFF1B1F1A)
        : const Color(0xFFEDF1E8);

    TextStyle style(double size, FontWeight weight, {double? letterSpacing}) {
      return GoogleFonts.inter(
        fontSize: size.sp,
        fontWeight: weight,
        color: onSurface,
        letterSpacing: letterSpacing,
      );
    }

    return TextTheme(
      headlineLarge: style(32, FontWeight.w700),
      headlineMedium: style(28, FontWeight.w700),
      headlineSmall: style(24, FontWeight.w600),
      titleLarge: style(22, FontWeight.w600),
      titleMedium: style(16, FontWeight.w600),
      titleSmall: style(14, FontWeight.w600),
      bodyLarge: style(16, FontWeight.w400),
      bodyMedium: style(14, FontWeight.w400),
      bodySmall: style(12, FontWeight.w400),
      labelLarge: style(14, FontWeight.w600, letterSpacing: 0.1),
      labelMedium: style(12, FontWeight.w600, letterSpacing: 0.1),
      labelSmall: style(11, FontWeight.w600, letterSpacing: 0.1),
    );
  }
}
