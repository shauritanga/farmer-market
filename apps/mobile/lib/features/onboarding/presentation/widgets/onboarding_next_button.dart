import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

/// Full-width pill button whose color flips relative to the page behind it
/// (white button on a colored page). Pulses gently on the last page to
/// draw the eye to "Get Started".
class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
    required this.label,
    required this.foregroundColor,
    required this.isLastPage,
    required this.onPressed,
  });

  final String label;
  final Color foregroundColor;
  final bool isLastPage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final button = SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 8.w),
            HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              size: 20.sp,
              color: foregroundColor,
            ),
          ],
        ),
      ),
    );

    if (!isLastPage) return button;

    return button
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(
          begin: 1,
          end: 1.03,
          duration: 900.ms,
          curve: Curves.easeInOut,
        );
  }
}
