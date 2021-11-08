import 'package:flutter/material.dart';

class Labels {
  Labels(this.locale);

  final Locale locale;

  static Labels of(BuildContext context) {
    return Localizations.of<Labels>(context, Labels)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Hello World',
      'email_label': 'Email',
      'password_label': 'Password',
      'signin_title': 'Sign in with',
      'signin_submit': 'SIGN IN',
      'email_mandatory': 'Please enter an email address',
      'password_mandatory': 'Please enter a password',
      'signin_subtitle': 'Or sign up with the classic way',
      'signup_submit': 'SIGN UP',
      'no_user_found': 'No user found for that email',
      'wrong_password': 'Wrong password provided for that user',
    },
    'es': {
      'title': 'Hola Mundo',
      'email_label': 'Correo Electrónico',
      'password_label': 'Contraseña',
      'signin_title': 'Acceder con',
      'signin_submit': 'ACCEDER',
      'email_mandatory': 'Ingrese una dirección de correo electrónico',
      'password_mandatory': 'Ingrese una contraseña',
      'signin_subtitle': 'O acceda de la forma clásica',
      'signup_submit': 'REGISTRARSE',
      'no_user_found': 'El usuario no existe',
      'wrong_password': 'Usuario o contraseña incorrectos',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  static String interpolate(String message, [List<dynamic> args = const []]) {
    for (var i = 0; i < args.length; i++) {
      message = message.replaceAll(r'$' + i.toString(), args[i]);
    }

    return message;
  }

  String getMessage(String key) => _localizedValues[locale.languageCode]![key]!;

  String get title => _localizedValues[locale.languageCode]!['title']!;
}
