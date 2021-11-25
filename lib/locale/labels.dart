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
      'password_repeat_label': 'Password Repeat',
      'signin_title': 'Sign in with',
      'signin_submit': 'SIGN IN',
      'email_mandatory': 'Please enter an email address',
      'password_mandatory': 'Please enter a password',
      'password_equals': 'The password must be the same',
      'signin_subtitle': 'Or sign up with the classic way',
      'signup_submit': 'SIGN UP',
      'no_user_found': 'No user found for that email',
      'wrong_password': 'Wrong password provided for that user',
      'signin_user': 'Sign in user successful',
      'signup_user': 'Registered user successfully',
      'weak_password': 'The password provided is too weak',
      'email_already_exists': 'The account already exists for that email.',
      'auth_method_not_allowed': 'authentication method not allowed',
      'cupboard_page_title': 'My Cupboards',
      'cupboard_name': 'Cupboard Name',
      'mandatory_name': 'Please enter a name',
      'new_cupboard': 'New Cupboard',
      'cancel_label': 'CANCEL',
      'save_label': 'SAVE',
      'show_products': 'Show Items',
      'select_image': 'Please select an image',
      'new_category': 'Create category',
      'view_options': 'View options',
      'category_name': 'Category name',
      'unknown_error': 'Unknown Error',
      'add_product': 'Add Product',
      'search_label': 'What are you looking for?',
      'quantity_label': 'Quantity',
      'category_label': 'Category',
      'category_mandatory': 'Please select a category',
      'validator_field_mandatory': 'The field is mandatory',
      'validator_length_min_max': r'Debe tener una longitud entre $0 y $1',
      'validator_invalid_email': 'No es un email válido',
      'quantity_mandatory': 'Please enter a quantity',
      'expiration_date_label': 'Expiration Date',
      'expiration_date_mandatory': 'Please select a date',
      'expiration_abreviation': 'Exp.',
    },
    'es': {
      'title': 'Hola Mundo',
      'email_label': 'Correo Electrónico',
      'password_label': 'Contraseña',
      'password_repeat_label': 'Repetir Contraseña',
      'signin_title': 'Acceder con',
      'signin_submit': 'ACCEDER',
      'email_mandatory': 'Ingrese una dirección de correo electrónico',
      'password_mandatory': 'Ingrese una contraseña',
      'password_equals': 'Las contraseñas deben ser iguales',
      'signin_subtitle': 'O acceda de la forma clásica',
      'signup_submit': 'REGISTRARSE',
      'no_user_found': 'El usuario no existe',
      'wrong_password': 'Usuario o contraseña incorrectos',
      'signin_user': 'Usuario autenticado',
      'signup_user': 'Usuario registrado correctamente',
      'weak_password': 'El password es muy débil',
      'email_already_exists':
          'El correo ya está asociado a un usuario existente',
      'auth_method_not_allowed': 'Método de autenticación inválido',
      'cupboard_page_title': 'Mis alacenas',
      'cupboard_name': 'Nombre Alacena',
      'mandatory_name': 'El nombre es obligatorio',
      'new_cupboard': 'Nueva Alacena',
      'cancel_label': 'CANCELAR',
      'save_label': 'GUARDAR',
      'show_products': 'Ver elementos',
      'select_image': 'Seleccione una imagen',
      'new_category': 'Crear categoría',
      'view_options': 'Opciones de vista',
      'category_name': 'Nombre Categoría',
      'unknown_error': 'Error desconocido',
      'add_product': 'Agregar Producto',
      'search_label': '¿Qué estás buscando?',
      'quantity_label': 'Cantidad',
      'category_label': 'Categoría',
      'category_mandatory': 'Seleccione una categoría',
      'validator_field_mandatory': 'Campo obligotario',
      'validator_length_min_max': r'Debe tener una longitud entre $0 y $1',
      'validator_invalid_email': 'No es un email válido',
      'quantity_mandatory': 'Ingrese una cantidad',
      'expiration_date_label': 'Fecha Expiración',
      'expiration_date_mandatory': 'Seleccione una fecha',
      'expiration_abreviation': 'Exp.',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  static String interpolate(String message, [List<dynamic> args = const []]) {
    for (var i = 0; i < args.length; i++) {
      message = message.replaceAll(r'$' + i.toString(), args[i].toString());
    }

    return message;
  }

  String getMessage(String? key, [List<dynamic> args = const []]) {
    if (key == null) {
      return "";
    }

    final localizedValues = _localizedValues[locale.languageCode];
    String? msg = key;

    if (localizedValues != null) {
      msg = localizedValues[key];
      msg = msg ?? key;
    } else {
      msg = key;
    }

    return interpolate(msg, args);
  }

  String get title => getMessage('title');
}
