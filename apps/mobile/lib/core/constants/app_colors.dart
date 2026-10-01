import 'package:flutter/material.dart';

/// Semantic/status colors and chart palette that `ColorScheme` (from
/// `AppTheme`'s FlexColorScheme setup) doesn't provide on its own. Brand
/// colors (primary/secondary/tertiary) live in `AppTheme` — read those off
/// `Theme.of(context).colorScheme`, not from here.
class AppColors {
  AppColors._();

  // Status colors — used via [StatusBadge] and [getStatusColor]. These are
  // generic UI conventions (green=success, amber=warning, red=error,
  // blue=info), not a brand identity.
  static const success = Color(0xFF22C55E);
  static const successContainer = Color(0xFFDCFCE7);
  static const warning = Color(0xFFF59E0B);
  static const warningContainer = Color(0xFFFEF3C7);
  static const error = Color(0xFFEF4444);
  static const errorContainer = Color(0xFFFEE2E2);
  static const info = Color(0xFF3B82F6);
  static const infoContainer = Color(0xFFDBEAFE);

  // Neutral scale for borders/dividers/placeholder surfaces not covered by
  // the seeded ColorScheme.
  static const grey50 = Color(0xFFFAFAFA);
  static const grey100 = Color(0xFFF5F5F5);
  static const grey200 = Color(0xFFE5E5E5);
  static const grey300 = Color(0xFFD4D4D4);
  static const grey400 = Color(0xFFA3A3A3);
  static const grey500 = Color(0xFF737373);
  static const grey600 = Color(0xFF525252);
  static const grey700 = Color(0xFF404040);
  static const grey800 = Color(0xFF262626);
  static const grey900 = Color(0xFF171717);

  static const chartColors = <Color>[
    Color(0xFF2E7D32),
    Color(0xFF3B82F6),
    Color(0xFFF59E0B),
    Color(0xFF8B5CF6),
    Color(0xFFEF4444),
    Color(0xFF14B8A6),
    Color(0xFFEC4899),
    Color(0xFF64748B),
  ];

  static Color getChartColor(int index) =>
      chartColors[index % chartColors.length];

  /// Maps a lifecycle/order/payment status string (see
  /// docs/architecture/architecture.md §8) to a status color. Unknown
  /// statuses fall back to [grey500] rather than guessing.
  static Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
      case 'PAID':
      case 'DELIVERED':
      case 'CONFIRMED':
      case 'ACTIVE':
      case 'ACCEPTED':
        return success;
      case 'PENDING':
      case 'PREPARING':
      case 'IN_TRANSIT':
      case 'PICKED_UP':
        return warning;
      case 'FAILED':
      case 'CANCELLED':
      case 'REJECTED':
      case 'REVERSED':
        return error;
      default:
        return grey500;
    }
  }
}
