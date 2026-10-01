import 'package:flutter/foundation.dart';
import 'package:smart_auth/smart_auth.dart';

/// Auto-fills the verification code from an incoming SMS via Android's SMS
/// User Consent API — the OS shows a one-time consent dialog for exactly
/// that message, so this never needs the dangerous `READ_SMS` permission.
/// Same package/approach as the sibling RealMoney borrower app's
/// `SmsCodeService`.
class SmsCodeService {
  bool get supported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Waits for a matching SMS. Returns the 6-digit code, or null if the
  /// platform isn't supported, the wait was cancelled, or no code could be
  /// parsed out of whatever message the user consented to.
  Future<String?> listen() async {
    if (!supported) return null;
    final result = await SmartAuth.instance.getSmsWithUserConsentApi();
    if (!result.hasData) return null;
    // Ignore unrelated messages the user might consent to by mistake —
    // the backend still validates the code either way.
    return RegExp(r'Your [Ff]ama verification code is (\d{6})\.')
        .firstMatch(result.requireData.sms)
        ?.group(1);
  }

  Future<void> stop() async {
    if (supported) {
      await SmartAuth.instance.removeUserConsentApiListener();
    }
  }
}
