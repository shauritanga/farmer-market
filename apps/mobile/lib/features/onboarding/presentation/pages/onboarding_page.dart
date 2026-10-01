import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/features/onboarding/domain/onboarding_page_data.dart';
import 'package:fama/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:fama/features/onboarding/presentation/widgets/onboarding_illustration.dart';
import 'package:fama/features/onboarding/presentation/widgets/onboarding_next_button.dart';
import 'package:fama/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:fama/l10n/app_localizations.dart';

List<OnboardingPageData> _pagesFor(AppLocalizations l10n) => [
  OnboardingPageData(
    title: l10n.onboardingPage1Title,
    description: l10n.onboardingPage1Description,
    icon: HugeIcons.strokeRoundedAnalytics01,
  ),
  OnboardingPageData(
    title: l10n.onboardingPage2Title,
    description: l10n.onboardingPage2Description,
    icon: HugeIcons.strokeRoundedStore01,
  ),
  OnboardingPageData(
    title: l10n.onboardingPage3Title,
    description: l10n.onboardingPage3Description,
    icon: HugeIcons.strokeRoundedDeliveryTruck01,
  ),
];

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const _pageCount = 3;

  Future<void> _complete() async {
    await ref.read(onboardingNotifierProvider.notifier).completeOnboarding();
    if (mounted) context.go(loginPath);
  }

  void _next() {
    if (_currentPage == _pageCount - 1) {
      _complete();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = _pagesFor(l10n);
    final colorScheme = Theme.of(context).colorScheme;
    final pageColors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
    ];
    final onPageColors = [
      colorScheme.onPrimary,
      colorScheme.onSecondary,
      colorScheme.onTertiary,
    ];

    final backgroundColor = pageColors[_currentPage];
    final onColor = onPageColors[_currentPage];
    final isLastPage = _currentPage == _pageCount - 1;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              _SkipButton(
                label: l10n.onboardingSkip,
                isVisible: !isLastPage,
                color: onColor,
                onPressed: _complete,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return _OnboardingPageContent(
                      page: page,
                      isActive: index == _currentPage,
                      onColor: onPageColors[index],
                    );
                  },
                ),
              ),
              OnboardingPageIndicator(
                count: pages.length,
                currentIndex: _currentPage,
                color: onColor,
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: OnboardingNextButton(
                  label: isLastPage
                      ? l10n.onboardingGetStarted
                      : l10n.onboardingContinue,
                  foregroundColor: backgroundColor,
                  isLastPage: isLastPage,
                  onPressed: _next,
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({
    required this.label,
    required this.isVisible,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final bool isVisible;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isVisible ? 1 : 0,
        child: Padding(
          padding: EdgeInsets.only(right: 8.w, top: 4.h),
          child: TextButton(
            onPressed: isVisible ? onPressed : null,
            child: Text(label, style: TextStyle(color: color)),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageContent extends StatelessWidget {
  const _OnboardingPageContent({
    required this.page,
    required this.isActive,
    required this.onColor,
  });

  final OnboardingPageData page;
  final bool isActive;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          OnboardingIllustration(
            icon: page.icon,
            isActive: isActive,
            onColor: onColor,
          ),
          SizedBox(height: 40.h),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(color: onColor),
          ),
          SizedBox(height: 16.h),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: onColor.withValues(alpha: 0.85)),
          ),
        ],
      ),
    );
  }
}
