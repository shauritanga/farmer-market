import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

/// Centered icon inside two concentric translucent rings plus a few
/// drifting "particle" dots — animates in only while [isActive], so the
/// off-screen `PageView` pages before/after stay static.
class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onColor,
  });

  final List<List<dynamic>> icon;
  final bool isActive;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    final target = isActive ? 1.0 : 0.0;

    return SizedBox(
      width: 260.w,
      height: 260.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _ring(280.w, 0.08, target, 0),
          _ring(220.w, 0.12, target, 100),
          _iconCircle(target),
          for (var i = 0; i < 4; i++) _particle(i, onColor),
        ],
      ),
    );
  }

  Widget _ring(double size, double opacity, double target, int delayMs) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: onColor.withValues(alpha: opacity),
          ),
        )
        .animate(target: target)
        .scale(
          begin: const Offset(0.6, 0.6),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: delayMs),
          duration: 500.ms,
          curve: Curves.easeOutBack,
        )
        .fadeIn(
          delay: Duration(milliseconds: delayMs),
          duration: 400.ms,
        );
  }

  Widget _iconCircle(double target) {
    return Container(
          width: 180.w,
          height: 180.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: onColor.withValues(alpha: 0.18),
          ),
          child: Center(
            child: HugeIcon(icon: icon, size: 64.sp, color: onColor),
          ),
        )
        .animate(target: target)
        .scale(
          begin: const Offset(0.7, 0.7),
          end: const Offset(1, 1),
          duration: 500.ms,
          curve: Curves.easeOutBack,
        )
        .fadeIn(duration: 400.ms);
  }

  static const _particlePositions = [
    Alignment(-0.9, -0.7),
    Alignment(0.85, -0.9),
    Alignment(-0.8, 0.85),
    Alignment(0.9, 0.8),
  ];

  Widget _particle(int index, Color color) {
    final dot = Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.5),
      ),
    );

    // Only attach the repeating drift animation while this page is active,
    // so off-screen PageView pages don't keep animating in the background
    // (see AGENTS.md §6: never run unnecessary animations).
    final child = isActive
        ? dot
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .moveY(
                begin: -6,
                end: 6,
                delay: Duration(milliseconds: index * 150),
                duration: (1400 + index * 200).ms,
                curve: Curves.easeInOut,
              )
        : dot;

    return Align(
      alignment: _particlePositions[index % _particlePositions.length],
      child: child,
    );
  }
}
