



import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  
  static final LocalAuthentication auth = LocalAuthentication();

  static avalibleBiometrics() async {
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

  static Future<( bool, String )> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to cpntinue',
        options: const AuthenticationOptions(
          // useErrorDialogs: false //TODO: FALSE AUTENTICATE PIN

        )
      );

      return ( didAuthenticate, didAuthenticate ? 'Hecho': 'Cancelado por el usuario' );
    } on PlatformException catch (e) {
      print('$e');

      if( e.code == auth_error.notEnrolled ) return ( false, 'No hay biometricos enrolados' );
      if( e.code == auth_error.lockedOut ) return ( false, 'Muchos intentos fallidos' );
      if( e.code == auth_error.notAvailable ) return ( false, 'No hay biometricos disponibles' );
      if( e.code == auth_error.passcodeNotSet ) return ( false, 'No hay un PIN configurado' );
      if( e.code == auth_error.permanentlyLockedOut ) return ( false, 'Se refiere desbloquear el telefono' );

      return ( false, e.toString() );
    }
  }



}