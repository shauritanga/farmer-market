// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Fama';

  @override
  String get onboardingSkip => 'Ruka';

  @override
  String get onboardingContinue => 'Endelea';

  @override
  String get onboardingGetStarted => 'Anza';

  @override
  String get onboardingPage1Title => 'Fahamu Soko Lako';

  @override
  String get onboardingPage1Description =>
      'Ona bei za sasa katika masoko mbalimbali, linganisha thamani halisi, na amua wapi kuuza kwa uhakika — si kubahatisha.';

  @override
  String get onboardingPage2Title => 'Uza kwa Uhakika';

  @override
  String get onboardingPage2Description =>
      'Weka mazao yako au gundua wanunuzi halisi, kisha kubaliana masharti kupitia mchakato safi wa kidijitali.';

  @override
  String get onboardingPage3Title => 'Fuatilia Kila Usafirishaji';

  @override
  String get onboardingPage3Description =>
      'Panga usafiri, thibitisha upokeaji na uwasilishaji, na upokee malipo — na rekodi unayoweza kuiamini.';

  @override
  String get loginTitle => 'Ingia';

  @override
  String get loginPhoneLabel => 'Nambari ya simu';

  @override
  String get phoneHint => 'mfano: 0712345678 au +255712345678';

  @override
  String get loginPasswordLabel => 'Nenosiri';

  @override
  String get loginSignInButton => 'Ingia';

  @override
  String get loginPhoneRequired => 'Nambari ya simu inahitajika';

  @override
  String get loginPasswordRequired => 'Nenosiri linahitajika';

  @override
  String get loginNoAccount => 'Huna akaunti?';

  @override
  String get loginRegisterLink => 'Jisajili';

  @override
  String get commonContinue => 'Endelea';

  @override
  String get registerNameTitle => 'Jina Lako Kamili';

  @override
  String get registerNameSubtitle => 'Tuanze na jina unalotumia kila siku';

  @override
  String get registerNameLabel => 'Jina kamili';

  @override
  String get registerNameRequired => 'Jina linahitajika';

  @override
  String get registerPhoneTitle => 'Nambari Yako ya Simu';

  @override
  String get registerPhoneSubtitle => 'Tutakutumia msimbo wa uthibitisho';

  @override
  String get registerSendCodeButton => 'Tuma Msimbo';

  @override
  String get registerCodeTitle => 'Weka Msimbo';

  @override
  String registerCodeSubtitle(String phone) {
    return 'Tumetuma msimbo wa tarakimu 6 kwa $phone';
  }

  @override
  String get registerCodeLabel => 'Msimbo wa uthibitisho';

  @override
  String get registerCodeRequired => 'Msimbo unahitajika';

  @override
  String get registerVerifyButton => 'Thibitisha';

  @override
  String registerResendIn(int seconds) {
    return 'Tuma tena baada ya sekunde $seconds';
  }

  @override
  String get registerResendCode => 'Tuma msimbo tena';

  @override
  String registerDevCodeHint(String code) {
    return 'Hali ya majaribio — hakuna SMS iliyotumwa. Msimbo wako ni $code.';
  }

  @override
  String get registerPasswordTitle => 'Unda Nenosiri';

  @override
  String get registerPasswordSubtitle => 'Linda akaunti yako kwa nenosiri';

  @override
  String get registerPasswordMinLength =>
      'Nenosiri lazima liwe angalau herufi 8';

  @override
  String get registerContinueButton => 'Endelea';

  @override
  String get roleSheetTitle => 'Chagua Jukumu Lako';

  @override
  String get roleSheetSubtitle => 'Hii itaamua utakachoona kwenye programu';

  @override
  String get roleSheetLabel => 'Jukumu';

  @override
  String get roleRequired => 'Tafadhali chagua jukumu lako';

  @override
  String get roleFarmer => 'Mkulima';

  @override
  String get roleBuyer => 'Mnunuzi';

  @override
  String get roleTransporter => 'Msafirishaji';

  @override
  String get registerCreateAccountButton => 'Fungua Akaunti';

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get settingsLanguageLabel => 'Lugha';

  @override
  String homeWelcomeTitle(String name) {
    return 'Karibu, $name!';
  }

  @override
  String get homeRoleFarmerMessage =>
      'Soko za bei, mazao yako, na maagizo yataonekana hapa hivi karibuni.';

  @override
  String get homeRoleBuyerMessage =>
      'Gundua mazao na wasiliana na wakulima hapa hivi karibuni.';

  @override
  String get homeRoleTransporterMessage =>
      'Kazi za usafirishaji zilizokabidhiwa zitaonekana hapa hivi karibuni.';

  @override
  String get homeSignOutButton => 'Toka';

  @override
  String get homeOverviewSubtitle =>
      'Fuatilia soko, mazao, na maagizo yako yote hapa.';

  @override
  String homeTopMarketTitle(String market) {
    return 'Bei za Soko Kuu: $market';
  }

  @override
  String get navHome => 'Nyumbani';

  @override
  String get navMarket => 'Soko';

  @override
  String get navProduce => 'Mazao';

  @override
  String get navOrders => 'Maagizo';

  @override
  String get navMore => 'Zaidi';

  @override
  String get marketPricesTitle => 'Bei za Soko';

  @override
  String get marketPricesLoadError => 'Imeshindwa kupakia bei za soko';

  @override
  String get marketPricesEmpty => 'Hakuna bei za soko kwa sasa';

  @override
  String get marketSearchHint => 'Tafuta bidhaa...';

  @override
  String get marketSearchEmpty => 'Hakuna matokeo';

  @override
  String get myProduceTitle => 'Mazao Yangu';

  @override
  String get myProduceLoadError => 'Imeshindwa kupakia mazao yako';

  @override
  String get myProduceEmpty => 'Bado hujaweka mazao yoyote';

  @override
  String get produceNegotiable => 'Bei inajadiliwa';

  @override
  String get myOrdersTitle => 'Maagizo Yangu';

  @override
  String get myOrdersLoadError => 'Imeshindwa kupakia maagizo';

  @override
  String get myOrdersEmpty => 'Bado huna maagizo';

  @override
  String get notificationsTitle => 'Arifa';

  @override
  String get notificationsLoadError => 'Imeshindwa kupakia arifa';

  @override
  String get notificationsEmpty => 'Hakuna arifa';

  @override
  String get moreNotifications => 'Arifa';

  @override
  String get commonRetry => 'Jaribu tena';

  @override
  String get commonCancel => 'Ghairi';

  @override
  String get commonConfirm => 'Thibitisha';

  @override
  String get updatedJustNow => 'Imesasishwa sasa hivi';

  @override
  String updatedMinutesAgo(int count) {
    return 'Imesasishwa dakika $count zilizopita';
  }

  @override
  String updatedHoursAgo(int count) {
    return 'Imesasishwa saa $count zilizopita';
  }

  @override
  String updatedDaysAgo(int count) {
    return 'Imesasishwa siku $count zilizopita';
  }

  @override
  String get buyerDemandsTitle => 'Mahitaji ya Wanunuzi';

  @override
  String get buyerDemandsSectionTitle => 'Mahitaji ya wanunuzi';

  @override
  String get buyerDemandsLoadError => 'Imeshindwa kupakia mahitaji ya wanunuzi';

  @override
  String get buyerDemandsEmpty => 'Hakuna mahitaji ya wanunuzi kwa sasa';

  @override
  String get buyerDemandsViewAll => 'Ona mahitaji yote';

  @override
  String buyerRequiredBy(String date) {
    return 'Inahitajika ifikapo $date';
  }

  @override
  String buyerPaymentTerms(String terms) {
    return 'Malipo: $terms';
  }

  @override
  String get moreBuyerDemands => 'Mahitaji ya Wanunuzi';

  @override
  String get inputsTitle => 'Pembejeo za Kilimo';

  @override
  String get inputsSectionTitle => 'Pembejeo za kilimo';

  @override
  String get inputsLoadError => 'Imeshindwa kupakia pembejeo';

  @override
  String get inputsEmpty => 'Hakuna pembejeo kwa sasa';

  @override
  String get inputsViewAll => 'Ona pembejeo zote';

  @override
  String get inputsOrderButton => 'Agiza';

  @override
  String get inputsQuantityLabel => 'Kiasi';

  @override
  String inputsOrderTitle(String name) {
    return 'Agiza $name';
  }

  @override
  String get inputsOrderSuccess => 'Ombi la kuagiza limetumwa';

  @override
  String get inputsOrderError => 'Imeshindwa kutuma ombi lako';

  @override
  String get inputsMyOrdersTitle => 'Maagizo Yangu ya Pembejeo';

  @override
  String get inputsMyOrdersEmpty => 'Bado hujaagiza pembejeo';

  @override
  String get inputsOutOfStock => 'Zimekwisha';

  @override
  String get moreInputs => 'Pembejeo za Kilimo';
}
