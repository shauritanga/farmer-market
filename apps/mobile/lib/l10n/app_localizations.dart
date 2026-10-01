import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('sw'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In sw, this message translates to:
  /// **'Fama'**
  String get appTitle;

  /// No description provided for @onboardingSkip.
  ///
  /// In sw, this message translates to:
  /// **'Ruka'**
  String get onboardingSkip;

  /// No description provided for @onboardingContinue.
  ///
  /// In sw, this message translates to:
  /// **'Endelea'**
  String get onboardingContinue;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In sw, this message translates to:
  /// **'Anza'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingPage1Title.
  ///
  /// In sw, this message translates to:
  /// **'Fahamu Soko Lako'**
  String get onboardingPage1Title;

  /// No description provided for @onboardingPage1Description.
  ///
  /// In sw, this message translates to:
  /// **'Ona bei za sasa katika masoko mbalimbali, linganisha thamani halisi, na amua wapi kuuza kwa uhakika — si kubahatisha.'**
  String get onboardingPage1Description;

  /// No description provided for @onboardingPage2Title.
  ///
  /// In sw, this message translates to:
  /// **'Uza kwa Uhakika'**
  String get onboardingPage2Title;

  /// No description provided for @onboardingPage2Description.
  ///
  /// In sw, this message translates to:
  /// **'Weka mazao yako au gundua wanunuzi halisi, kisha kubaliana masharti kupitia mchakato safi wa kidijitali.'**
  String get onboardingPage2Description;

  /// No description provided for @onboardingPage3Title.
  ///
  /// In sw, this message translates to:
  /// **'Fuatilia Kila Usafirishaji'**
  String get onboardingPage3Title;

  /// No description provided for @onboardingPage3Description.
  ///
  /// In sw, this message translates to:
  /// **'Panga usafiri, thibitisha upokeaji na uwasilishaji, na upokee malipo — na rekodi unayoweza kuiamini.'**
  String get onboardingPage3Description;

  /// No description provided for @loginTitle.
  ///
  /// In sw, this message translates to:
  /// **'Ingia'**
  String get loginTitle;

  /// No description provided for @loginPhoneLabel.
  ///
  /// In sw, this message translates to:
  /// **'Nambari ya simu'**
  String get loginPhoneLabel;

  /// No description provided for @phoneHint.
  ///
  /// In sw, this message translates to:
  /// **'mfano: 0712345678 au +255712345678'**
  String get phoneHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In sw, this message translates to:
  /// **'Nenosiri'**
  String get loginPasswordLabel;

  /// No description provided for @loginSignInButton.
  ///
  /// In sw, this message translates to:
  /// **'Ingia'**
  String get loginSignInButton;

  /// No description provided for @loginPhoneRequired.
  ///
  /// In sw, this message translates to:
  /// **'Nambari ya simu inahitajika'**
  String get loginPhoneRequired;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In sw, this message translates to:
  /// **'Nenosiri linahitajika'**
  String get loginPasswordRequired;

  /// No description provided for @loginNoAccount.
  ///
  /// In sw, this message translates to:
  /// **'Huna akaunti?'**
  String get loginNoAccount;

  /// No description provided for @loginRegisterLink.
  ///
  /// In sw, this message translates to:
  /// **'Jisajili'**
  String get loginRegisterLink;

  /// No description provided for @commonContinue.
  ///
  /// In sw, this message translates to:
  /// **'Endelea'**
  String get commonContinue;

  /// No description provided for @registerNameTitle.
  ///
  /// In sw, this message translates to:
  /// **'Jina Lako Kamili'**
  String get registerNameTitle;

  /// No description provided for @registerNameSubtitle.
  ///
  /// In sw, this message translates to:
  /// **'Tuanze na jina unalotumia kila siku'**
  String get registerNameSubtitle;

  /// No description provided for @registerNameLabel.
  ///
  /// In sw, this message translates to:
  /// **'Jina kamili'**
  String get registerNameLabel;

  /// No description provided for @registerNameRequired.
  ///
  /// In sw, this message translates to:
  /// **'Jina linahitajika'**
  String get registerNameRequired;

  /// No description provided for @registerPhoneTitle.
  ///
  /// In sw, this message translates to:
  /// **'Nambari Yako ya Simu'**
  String get registerPhoneTitle;

  /// No description provided for @registerPhoneSubtitle.
  ///
  /// In sw, this message translates to:
  /// **'Tutakutumia msimbo wa uthibitisho'**
  String get registerPhoneSubtitle;

  /// No description provided for @registerSendCodeButton.
  ///
  /// In sw, this message translates to:
  /// **'Tuma Msimbo'**
  String get registerSendCodeButton;

  /// No description provided for @registerCodeTitle.
  ///
  /// In sw, this message translates to:
  /// **'Weka Msimbo'**
  String get registerCodeTitle;

  /// No description provided for @registerCodeSubtitle.
  ///
  /// In sw, this message translates to:
  /// **'Tumetuma msimbo wa tarakimu 6 kwa {phone}'**
  String registerCodeSubtitle(String phone);

  /// No description provided for @registerCodeLabel.
  ///
  /// In sw, this message translates to:
  /// **'Msimbo wa uthibitisho'**
  String get registerCodeLabel;

  /// No description provided for @registerCodeRequired.
  ///
  /// In sw, this message translates to:
  /// **'Msimbo unahitajika'**
  String get registerCodeRequired;

  /// No description provided for @registerVerifyButton.
  ///
  /// In sw, this message translates to:
  /// **'Thibitisha'**
  String get registerVerifyButton;

  /// No description provided for @registerResendIn.
  ///
  /// In sw, this message translates to:
  /// **'Tuma tena baada ya sekunde {seconds}'**
  String registerResendIn(int seconds);

  /// No description provided for @registerResendCode.
  ///
  /// In sw, this message translates to:
  /// **'Tuma msimbo tena'**
  String get registerResendCode;

  /// No description provided for @registerDevCodeHint.
  ///
  /// In sw, this message translates to:
  /// **'Hali ya majaribio — hakuna SMS iliyotumwa. Msimbo wako ni {code}.'**
  String registerDevCodeHint(String code);

  /// No description provided for @registerPasswordTitle.
  ///
  /// In sw, this message translates to:
  /// **'Unda Nenosiri'**
  String get registerPasswordTitle;

  /// No description provided for @registerPasswordSubtitle.
  ///
  /// In sw, this message translates to:
  /// **'Linda akaunti yako kwa nenosiri'**
  String get registerPasswordSubtitle;

  /// No description provided for @registerPasswordMinLength.
  ///
  /// In sw, this message translates to:
  /// **'Nenosiri lazima liwe angalau herufi 8'**
  String get registerPasswordMinLength;

  /// No description provided for @registerContinueButton.
  ///
  /// In sw, this message translates to:
  /// **'Endelea'**
  String get registerContinueButton;

  /// No description provided for @roleSheetTitle.
  ///
  /// In sw, this message translates to:
  /// **'Chagua Jukumu Lako'**
  String get roleSheetTitle;

  /// No description provided for @roleSheetSubtitle.
  ///
  /// In sw, this message translates to:
  /// **'Hii itaamua utakachoona kwenye programu'**
  String get roleSheetSubtitle;

  /// No description provided for @roleSheetLabel.
  ///
  /// In sw, this message translates to:
  /// **'Jukumu'**
  String get roleSheetLabel;

  /// No description provided for @roleRequired.
  ///
  /// In sw, this message translates to:
  /// **'Tafadhali chagua jukumu lako'**
  String get roleRequired;

  /// No description provided for @roleFarmer.
  ///
  /// In sw, this message translates to:
  /// **'Mkulima'**
  String get roleFarmer;

  /// No description provided for @roleBuyer.
  ///
  /// In sw, this message translates to:
  /// **'Mnunuzi'**
  String get roleBuyer;

  /// No description provided for @roleTransporter.
  ///
  /// In sw, this message translates to:
  /// **'Msafirishaji'**
  String get roleTransporter;

  /// No description provided for @registerCreateAccountButton.
  ///
  /// In sw, this message translates to:
  /// **'Fungua Akaunti'**
  String get registerCreateAccountButton;

  /// No description provided for @settingsTitle.
  ///
  /// In sw, this message translates to:
  /// **'Mipangilio'**
  String get settingsTitle;

  /// No description provided for @settingsLanguageLabel.
  ///
  /// In sw, this message translates to:
  /// **'Lugha'**
  String get settingsLanguageLabel;

  /// No description provided for @homeWelcomeTitle.
  ///
  /// In sw, this message translates to:
  /// **'Karibu, {name}!'**
  String homeWelcomeTitle(String name);

  /// No description provided for @homeRoleFarmerMessage.
  ///
  /// In sw, this message translates to:
  /// **'Soko za bei, mazao yako, na maagizo yataonekana hapa hivi karibuni.'**
  String get homeRoleFarmerMessage;

  /// No description provided for @homeRoleBuyerMessage.
  ///
  /// In sw, this message translates to:
  /// **'Gundua mazao na wasiliana na wakulima hapa hivi karibuni.'**
  String get homeRoleBuyerMessage;

  /// No description provided for @homeRoleTransporterMessage.
  ///
  /// In sw, this message translates to:
  /// **'Kazi za usafirishaji zilizokabidhiwa zitaonekana hapa hivi karibuni.'**
  String get homeRoleTransporterMessage;

  /// No description provided for @homeSignOutButton.
  ///
  /// In sw, this message translates to:
  /// **'Toka'**
  String get homeSignOutButton;

  /// No description provided for @homeOverviewSubtitle.
  ///
  /// In sw, this message translates to:
  /// **'Fuatilia soko, mazao, na maagizo yako yote hapa.'**
  String get homeOverviewSubtitle;

  /// No description provided for @homeTopMarketTitle.
  ///
  /// In sw, this message translates to:
  /// **'Bei za Soko Kuu: {market}'**
  String homeTopMarketTitle(String market);

  /// No description provided for @navHome.
  ///
  /// In sw, this message translates to:
  /// **'Nyumbani'**
  String get navHome;

  /// No description provided for @navMarket.
  ///
  /// In sw, this message translates to:
  /// **'Soko'**
  String get navMarket;

  /// No description provided for @navProduce.
  ///
  /// In sw, this message translates to:
  /// **'Mazao'**
  String get navProduce;

  /// No description provided for @navOrders.
  ///
  /// In sw, this message translates to:
  /// **'Maagizo'**
  String get navOrders;

  /// No description provided for @navMore.
  ///
  /// In sw, this message translates to:
  /// **'Zaidi'**
  String get navMore;

  /// No description provided for @marketPricesTitle.
  ///
  /// In sw, this message translates to:
  /// **'Bei za Soko'**
  String get marketPricesTitle;

  /// No description provided for @marketPricesLoadError.
  ///
  /// In sw, this message translates to:
  /// **'Imeshindwa kupakia bei za soko'**
  String get marketPricesLoadError;

  /// No description provided for @marketPricesEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Hakuna bei za soko kwa sasa'**
  String get marketPricesEmpty;

  /// No description provided for @marketSearchHint.
  ///
  /// In sw, this message translates to:
  /// **'Tafuta bidhaa...'**
  String get marketSearchHint;

  /// No description provided for @marketSearchEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Hakuna matokeo'**
  String get marketSearchEmpty;

  /// No description provided for @myProduceTitle.
  ///
  /// In sw, this message translates to:
  /// **'Mazao Yangu'**
  String get myProduceTitle;

  /// No description provided for @myProduceLoadError.
  ///
  /// In sw, this message translates to:
  /// **'Imeshindwa kupakia mazao yako'**
  String get myProduceLoadError;

  /// No description provided for @myProduceEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Bado hujaweka mazao yoyote'**
  String get myProduceEmpty;

  /// No description provided for @produceNegotiable.
  ///
  /// In sw, this message translates to:
  /// **'Bei inajadiliwa'**
  String get produceNegotiable;

  /// No description provided for @myOrdersTitle.
  ///
  /// In sw, this message translates to:
  /// **'Maagizo Yangu'**
  String get myOrdersTitle;

  /// No description provided for @myOrdersLoadError.
  ///
  /// In sw, this message translates to:
  /// **'Imeshindwa kupakia maagizo'**
  String get myOrdersLoadError;

  /// No description provided for @myOrdersEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Bado huna maagizo'**
  String get myOrdersEmpty;

  /// No description provided for @notificationsTitle.
  ///
  /// In sw, this message translates to:
  /// **'Arifa'**
  String get notificationsTitle;

  /// No description provided for @notificationsLoadError.
  ///
  /// In sw, this message translates to:
  /// **'Imeshindwa kupakia arifa'**
  String get notificationsLoadError;

  /// No description provided for @notificationsEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Hakuna arifa'**
  String get notificationsEmpty;

  /// No description provided for @moreNotifications.
  ///
  /// In sw, this message translates to:
  /// **'Arifa'**
  String get moreNotifications;

  /// No description provided for @commonRetry.
  ///
  /// In sw, this message translates to:
  /// **'Jaribu tena'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In sw, this message translates to:
  /// **'Ghairi'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In sw, this message translates to:
  /// **'Thibitisha'**
  String get commonConfirm;

  /// No description provided for @updatedJustNow.
  ///
  /// In sw, this message translates to:
  /// **'Imesasishwa sasa hivi'**
  String get updatedJustNow;

  /// No description provided for @updatedMinutesAgo.
  ///
  /// In sw, this message translates to:
  /// **'Imesasishwa dakika {count} zilizopita'**
  String updatedMinutesAgo(int count);

  /// No description provided for @updatedHoursAgo.
  ///
  /// In sw, this message translates to:
  /// **'Imesasishwa saa {count} zilizopita'**
  String updatedHoursAgo(int count);

  /// No description provided for @updatedDaysAgo.
  ///
  /// In sw, this message translates to:
  /// **'Imesasishwa siku {count} zilizopita'**
  String updatedDaysAgo(int count);

  /// No description provided for @buyerDemandsTitle.
  ///
  /// In sw, this message translates to:
  /// **'Mahitaji ya Wanunuzi'**
  String get buyerDemandsTitle;

  /// No description provided for @buyerDemandsSectionTitle.
  ///
  /// In sw, this message translates to:
  /// **'Mahitaji ya wanunuzi'**
  String get buyerDemandsSectionTitle;

  /// No description provided for @buyerDemandsLoadError.
  ///
  /// In sw, this message translates to:
  /// **'Imeshindwa kupakia mahitaji ya wanunuzi'**
  String get buyerDemandsLoadError;

  /// No description provided for @buyerDemandsEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Hakuna mahitaji ya wanunuzi kwa sasa'**
  String get buyerDemandsEmpty;

  /// No description provided for @buyerDemandsViewAll.
  ///
  /// In sw, this message translates to:
  /// **'Ona mahitaji yote'**
  String get buyerDemandsViewAll;

  /// No description provided for @buyerRequiredBy.
  ///
  /// In sw, this message translates to:
  /// **'Inahitajika ifikapo {date}'**
  String buyerRequiredBy(String date);

  /// No description provided for @buyerPaymentTerms.
  ///
  /// In sw, this message translates to:
  /// **'Malipo: {terms}'**
  String buyerPaymentTerms(String terms);

  /// No description provided for @moreBuyerDemands.
  ///
  /// In sw, this message translates to:
  /// **'Mahitaji ya Wanunuzi'**
  String get moreBuyerDemands;

  /// No description provided for @inputsTitle.
  ///
  /// In sw, this message translates to:
  /// **'Pembejeo za Kilimo'**
  String get inputsTitle;

  /// No description provided for @inputsSectionTitle.
  ///
  /// In sw, this message translates to:
  /// **'Pembejeo za kilimo'**
  String get inputsSectionTitle;

  /// No description provided for @inputsLoadError.
  ///
  /// In sw, this message translates to:
  /// **'Imeshindwa kupakia pembejeo'**
  String get inputsLoadError;

  /// No description provided for @inputsEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Hakuna pembejeo kwa sasa'**
  String get inputsEmpty;

  /// No description provided for @inputsViewAll.
  ///
  /// In sw, this message translates to:
  /// **'Ona pembejeo zote'**
  String get inputsViewAll;

  /// No description provided for @inputsOrderButton.
  ///
  /// In sw, this message translates to:
  /// **'Agiza'**
  String get inputsOrderButton;

  /// No description provided for @inputsQuantityLabel.
  ///
  /// In sw, this message translates to:
  /// **'Kiasi'**
  String get inputsQuantityLabel;

  /// No description provided for @inputsOrderTitle.
  ///
  /// In sw, this message translates to:
  /// **'Agiza {name}'**
  String inputsOrderTitle(String name);

  /// No description provided for @inputsOrderSuccess.
  ///
  /// In sw, this message translates to:
  /// **'Ombi la kuagiza limetumwa'**
  String get inputsOrderSuccess;

  /// No description provided for @inputsOrderError.
  ///
  /// In sw, this message translates to:
  /// **'Imeshindwa kutuma ombi lako'**
  String get inputsOrderError;

  /// No description provided for @inputsMyOrdersTitle.
  ///
  /// In sw, this message translates to:
  /// **'Maagizo Yangu ya Pembejeo'**
  String get inputsMyOrdersTitle;

  /// No description provided for @inputsMyOrdersEmpty.
  ///
  /// In sw, this message translates to:
  /// **'Bado hujaagiza pembejeo'**
  String get inputsMyOrdersEmpty;

  /// No description provided for @inputsOutOfStock.
  ///
  /// In sw, this message translates to:
  /// **'Zimekwisha'**
  String get inputsOutOfStock;

  /// No description provided for @moreInputs.
  ///
  /// In sw, this message translates to:
  /// **'Pembejeo za Kilimo'**
  String get moreInputs;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
