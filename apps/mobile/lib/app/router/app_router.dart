import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fama/app/router/router_refresh_listenable.dart';
import 'package:fama/features/authentication/presentation/pages/login_page.dart';
import 'package:fama/features/authentication/presentation/pages/register_name_page.dart';
import 'package:fama/features/authentication/presentation/pages/register_password_page.dart';
import 'package:fama/features/authentication/presentation/pages/register_phone_page.dart';
import 'package:fama/features/authentication/presentation/pages/register_role_page.dart';
import 'package:fama/features/authentication/presentation/pages/register_verify_code_page.dart';
import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/authentication/presentation/state/auth_state.dart';
import 'package:fama/features/buyers/presentation/pages/buyer_demands_page.dart';
import 'package:fama/features/home/presentation/pages/home_page.dart';
import 'package:fama/features/inputs/presentation/pages/inputs_catalog_page.dart';
import 'package:fama/features/inputs/presentation/pages/my_input_orders_page.dart';
import 'package:fama/features/market_prices/presentation/pages/market_search_page.dart';
import 'package:fama/features/notifications/presentation/pages/notifications_page.dart';
import 'package:fama/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:fama/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:fama/features/settings/presentation/pages/settings_page.dart';

const onboardingPath = '/onboarding';
const loginPath = '/login';
const registerNamePath = '/register/name';
const registerPhonePath = '/register/phone';
const registerVerifyPath = '/register/verify';
const registerPasswordPath = '/register/password';
const registerRolePath = '/register/role';
const homePath = '/home';
const settingsPath = '/settings';
const notificationsPath = '/notifications';
const marketSearchPath = '/market-search';
const buyerDemandsPath = '/buyer-demands';
const inputsPath = '/inputs';
const myInputOrdersPath = '/inputs/orders';

/// Central route table. As features grow, prefer each feature exposing its
/// own `GoRoute` list and composing them here rather than growing this file
/// past a readable size.
final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = RouterRefreshListenable();
  ref.listen(
    onboardingNotifierProvider,
    (previous, next) => refreshListenable.refresh(),
  );
  ref.listen(
    authNotifierProvider,
    (previous, next) => refreshListenable.refresh(),
  );
  ref.onDispose(refreshListenable.dispose);

  return GoRouter(
    initialLocation: onboardingPath,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final hasCompletedOnboarding = ref.read(onboardingNotifierProvider);
      final isAuthenticated =
          ref.read(authNotifierProvider) is AuthAuthenticated;

      final isOnboardingRoute = state.matchedLocation == onboardingPath;
      final isAuthFlowRoute =
          state.matchedLocation == loginPath ||
          state.matchedLocation.startsWith('/register');

      if (!hasCompletedOnboarding && !isOnboardingRoute) {
        return onboardingPath;
      }
      if (hasCompletedOnboarding && isOnboardingRoute) {
        return loginPath;
      }
      // An authenticated user has no business sitting on the login/register
      // screens (e.g. registration just completed, or a stale deep link) —
      // send them home. Settings stays reachable either way.
      if (isAuthenticated && isAuthFlowRoute) {
        return homePath;
      }
      if (!isAuthenticated &&
          !isAuthFlowRoute &&
          !isOnboardingRoute &&
          state.matchedLocation != settingsPath) {
        return loginPath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: onboardingPath,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: loginPath,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: registerNamePath,
        name: 'register-name',
        builder: (context, state) => const RegisterNamePage(),
      ),
      GoRoute(
        path: registerPhonePath,
        name: 'register-phone',
        builder: (context, state) => const RegisterPhonePage(),
      ),
      GoRoute(
        path: registerVerifyPath,
        name: 'register-verify',
        builder: (context, state) => const RegisterVerifyCodePage(),
      ),
      GoRoute(
        path: registerPasswordPath,
        name: 'register-password',
        builder: (context, state) => const RegisterPasswordPage(),
      ),
      GoRoute(
        path: registerRolePath,
        name: 'register-role',
        builder: (context, state) => const RegisterRolePage(),
      ),
      GoRoute(
        path: homePath,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: settingsPath,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: notificationsPath,
        name: 'notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: marketSearchPath,
        name: 'market-search',
        builder: (context, state) => const MarketSearchPage(),
      ),
      GoRoute(
        path: buyerDemandsPath,
        name: 'buyer-demands',
        builder: (context, state) => const BuyerDemandsPage(),
      ),
      GoRoute(
        path: inputsPath,
        name: 'inputs',
        builder: (context, state) => const InputsCatalogPage(),
      ),
      GoRoute(
        path: myInputOrdersPath,
        name: 'my-input-orders',
        builder: (context, state) => const MyInputOrdersPage(),
      ),
    ],
  );
});
