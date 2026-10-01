import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Active page = a wide pill, inactive = a small faded dot.
class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.color,
  });

  final int count;
  final int currentIndex;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 32.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: color.withValues(alpha: isActive ? 1 : 0.4),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
