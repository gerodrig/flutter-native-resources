import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate(
      {bool biometricOnly = false}) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to continue',
          options: AuthenticationOptions(
            biometricOnly: biometricOnly,
            // useErrorDialogs: false // ask for PIN etc
          ));

      return (
        didAuthenticate,
        didAuthenticate ? 'Authenticated' : 'User Cancelled'
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled)
        return (false, 'Biometric not enrolled');
      if (e.code == auth_error.lockedOut)
        return (false, 'Biometric locked out');
      if (e.code == auth_error.notAvailable)
        return (false, 'Biometric not available');
      if (e.code == auth_error.passcodeNotSet)
        return (false, 'Passcode not set');
      if (e.code == auth_error.permanentlyLockedOut)
        return (false, 'Permanently locked out');

      return (false, 'Error: ${e.code}');
    }
  }
}
