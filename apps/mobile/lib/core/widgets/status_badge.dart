import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Communicates status (order/payment/transport lifecycle) without relying
/// on color alone — always pair color with a label. See AGENTS.md §13.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.tone});

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (background, foreground) = switch (tone) {
      StatusTone.neutral => (
        colorScheme.surfaceContainerHighest,
        colorScheme.onSurfaceVariant,
      ),
      StatusTone.pending => (
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
      ),
      StatusTone.success => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
      ),
      StatusTone.error => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: foreground),
      ),
    );
  }
}

enum StatusTone { neutral, pending, success, error }
