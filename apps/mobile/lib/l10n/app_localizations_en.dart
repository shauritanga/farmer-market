// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fama';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingPage1Title => 'Know Your Market';

  @override
  String get onboardingPage1Description =>
      'See current prices across markets, compare net value, and decide where to sell with confidence — not guesswork.';

  @override
  String get onboardingPage2Title => 'Sell With Confidence';

  @override
  String get onboardingPage2Description =>
      'List your produce or discover real buyer demand, and agree terms through a clear digital workflow.';

  @override
  String get onboardingPage3Title => 'Track Every Delivery';

  @override
  String get onboardingPage3Description =>
      'Arrange transport, verify pickup and delivery, and get paid — with a record you can trust.';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginPhoneLabel => 'Phone number';

  @override
  String get phoneHint => 'e.g. 0712345678 or +255712345678';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginSignInButton => 'Sign in';

  @override
  String get loginPhoneRequired => 'Phone number is required';

  @override
  String get loginPasswordRequired => 'Password is required';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginRegisterLink => 'Register';

  @override
  String get commonContinue => 'Continue';

  @override
  String get registerNameTitle => 'Your Full Name';

  @override
  String get registerNameSubtitle => 'Let\'s start with the name you go by';

  @override
  String get registerNameLabel => 'Full name';

  @override
  String get registerNameRequired => 'Full name is required';

  @override
  String get registerPhoneTitle => 'Your Phone Number';

  @override
  String get registerPhoneSubtitle => 'We\'ll send you a verification code';

  @override
  String get registerSendCodeButton => 'Send Code';

  @override
  String get registerCodeTitle => 'Enter Code';

  @override
  String registerCodeSubtitle(String phone) {
    return 'We sent a 6-digit code to $phone';
  }

  @override
  String get registerCodeLabel => 'Verification code';

  @override
  String get registerCodeRequired => 'Code is required';

  @override
  String get registerVerifyButton => 'Verify';

  @override
  String registerResendIn(int seconds) {
    return 'Resend in $seconds seconds';
  }

  @override
  String get registerResendCode => 'Resend code';

  @override
  String registerDevCodeHint(String code) {
    return 'Development mode — no SMS was sent. Your code is $code.';
  }

  @override
  String get registerPasswordTitle => 'Create a Password';

  @override
  String get registerPasswordSubtitle => 'Secure your account with a password';

  @override
  String get registerPasswordMinLength =>
      'Password must be at least 8 characters';

  @override
  String get registerContinueButton => 'Continue';

  @override
  String get roleSheetTitle => 'Choose Your Role';

  @override
  String get roleSheetSubtitle => 'This decides what you\'ll see in the app';

  @override
  String get roleSheetLabel => 'Role';

  @override
  String get roleRequired => 'Please select your role';

  @override
  String get roleFarmer => 'Farmer';

  @override
  String get roleBuyer => 'Buyer';

  @override
  String get roleTransporter => 'Transporter';

  @override
  String get registerCreateAccountButton => 'Create Account';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguageLabel => 'Language';

  @override
  String homeWelcomeTitle(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get homeRoleFarmerMessage =>
      'Market prices, your produce, and orders will show up here soon.';

  @override
  String get homeRoleBuyerMessage =>
      'Discover produce and reach farmers here soon.';

  @override
  String get homeRoleTransporterMessage =>
      'Transport jobs assigned to you will show up here soon.';

  @override
  String get homeSignOutButton => 'Sign out';

  @override
  String get homeOverviewSubtitle =>
      'Track your market, produce, and orders all in one place.';

  @override
  String homeTopMarketTitle(String market) {
    return 'Top Market Prices: $market';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navMarket => 'Market';

  @override
  String get navProduce => 'Produce';

  @override
  String get navOrders => 'Orders';

  @override
  String get navMore => 'More';

  @override
  String get marketPricesTitle => 'Market Prices';

  @override
  String get marketPricesLoadError => 'Couldn\'t load market prices';

  @override
  String get marketPricesEmpty => 'No market prices yet';

  @override
  String get marketSearchHint => 'Search products...';

  @override
  String get marketSearchEmpty => 'No results';

  @override
  String get myProduceTitle => 'My Produce';

  @override
  String get myProduceLoadError => 'Couldn\'t load your produce';

  @override
  String get myProduceEmpty => 'You haven\'t listed any produce yet';

  @override
  String get produceNegotiable => 'Negotiable';

  @override
  String get myOrdersTitle => 'My Orders';

  @override
  String get myOrdersLoadError => 'Couldn\'t load orders';

  @override
  String get myOrdersEmpty => 'You don\'t have any orders yet';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsLoadError => 'Couldn\'t load notifications';

  @override
  String get notificationsEmpty => 'No notifications';

  @override
  String get moreNotifications => 'Notifications';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get updatedJustNow => 'Updated just now';

  @override
  String updatedMinutesAgo(int count) {
    return 'Updated $count min ago';
  }

  @override
  String updatedHoursAgo(int count) {
    return 'Updated $count hr ago';
  }

  @override
  String updatedDaysAgo(int count) {
    return 'Updated $count days ago';
  }

  @override
  String get buyerDemandsTitle => 'Buyer Requests';

  @override
  String get buyerDemandsSectionTitle => 'Buyer requests';

  @override
  String get buyerDemandsLoadError => 'Couldn\'t load buyer requests';

  @override
  String get buyerDemandsEmpty => 'No buyer requests right now';

  @override
  String get buyerDemandsViewAll => 'View all requests';

  @override
  String buyerRequiredBy(String date) {
    return 'Needed by $date';
  }

  @override
  String buyerPaymentTerms(String terms) {
    return 'Payment: $terms';
  }

  @override
  String get moreBuyerDemands => 'Buyer Requests';

  @override
  String get inputsTitle => 'Farm Inputs';

  @override
  String get inputsSectionTitle => 'Farm inputs';

  @override
  String get inputsLoadError => 'Couldn\'t load farm inputs';

  @override
  String get inputsEmpty => 'No farm inputs available';

  @override
  String get inputsViewAll => 'View all inputs';

  @override
  String get inputsOrderButton => 'Order';

  @override
  String get inputsQuantityLabel => 'Quantity';

  @override
  String inputsOrderTitle(String name) {
    return 'Order $name';
  }

  @override
  String get inputsOrderSuccess => 'Order request sent';

  @override
  String get inputsOrderError => 'Couldn\'t place your order';

  @override
  String get inputsMyOrdersTitle => 'My Input Orders';

  @override
  String get inputsMyOrdersEmpty => 'You haven\'t ordered any inputs yet';

  @override
  String get inputsOutOfStock => 'Out of stock';

  @override
  String get moreInputs => 'Farm Inputs';
}
