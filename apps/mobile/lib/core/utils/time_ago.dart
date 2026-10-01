import 'package:fama/l10n/app_localizations.dart';

/// Localized relative freshness label for a recorded timestamp, e.g.
/// "Updated 3 min ago". Prices fluctuate, so every displayed price must
/// say *when* it was recorded — see product-spec.md §3 (Trust).
///
/// Timestamps in the future (clock skew, bad data) read as "just now"
/// rather than a negative duration.
String formatUpdatedAgo(
  DateTime timestamp,
  AppLocalizations l10n, {
  DateTime? now,
}) {
  final current = (now ?? DateTime.now()).toUtc();
  final difference = current.difference(timestamp.toUtc());

  if (difference.isNegative || difference.inMinutes < 1) {
    return l10n.updatedJustNow;
  }
  if (difference.inHours < 1) {
    return l10n.updatedMinutesAgo(difference.inMinutes);
  }
  if (difference.inDays < 1) {
    return l10n.updatedHoursAgo(difference.inHours);
  }
  return l10n.updatedDaysAgo(difference.inDays);
}
