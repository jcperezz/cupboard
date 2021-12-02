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
      'new_category': 'New category',
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
      'expiration_date_abr': r'Exp. $0',
      'quantity_abr': r'x $0',
      'filter_by_label': r'Filter By',
      'show_all': r'Show All [ $0 ]',
      'expired_option': r'Expired [ $0 ]',
      'close_to_expire_option': r'Close to expire [ $0 ]',
      'avalaible_option': r'Avalaibles [ $0 ]',
      'empty_label': r'[ Empty ]',
      'count_item_label': r'[ $0 items ]',
      'delete_label': r'Delete Item',
      'delete_confirm': r'Do you want to delete $0?',
      'delete_successful': r'Delete successful',
      'search_add_label': 'What would you like to add?',
      'add_cupboard': 'Add Cupboard',
      'sign_out_label': 'Close',
      'home_navbar_label': 'Home',
      'categories_navbar_label': 'Shopping Cart',
      'cart_navbar_label': 'Shopping Cart',
      'profile_navbar_label': 'My Profile',
      'count_inventory_all': r'$0 total items',
      'count_inventory_close_to_expire': r'$0 items close to expire',
      'count_inventory_expired': r'$0 items expired',
      'empty_cupboards': 'Ups! is empty, add a cupboard',
      'empty_cupboard': 'Ups! is empty, add products',
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
      'new_category': 'Nueva categoría',
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
      'expiration_date_abr': r'Exp. $0',
      'quantity_abr': r'x $0',
      'filter_by_label': r'Filtro por',
      'show_all': r'Ver todos [ $0 ]',
      'expired_option': r'Expirados [ $0 ]',
      'close_to_expire_option': r'Cerca de expirar [ $0 ]',
      'avalaible_option': r'Vigentes [ $0 ]',
      'empty_label': r'[ No hay elementos ]',
      'count_item_label': r'[ $0 ítems ]',
      'delete_label': r'Eliminar Ítem',
      'delete_confirm': r'¿Deseas eliminar $0?',
      'delete_successful': r'Eliminación exitosa',
      'search_add_label': '¿Qué te gustaría agregar?',
      'add_cupboard': 'Agregar Alacena',
      'sign_out_label': 'Cerrar',
      'home_navbar_label': 'Inicio',
      'categories_navbar_label': 'Categorías',
      'cart_navbar_label': 'Carrito de compras',
      'profile_navbar_label': 'Mi perfil',
      'count_inventory_all': r'$0 productos en la alacena',
      'count_inventory_close_to_expire': r'$0 productos cerca de expirar',
      'count_inventory_expired': r'$0 productos expirados',
      'empty_cupboards': 'Ups! está vacío, agrega una alacena',
      'empty_cupboard': 'Ups! está vacío, agrega productos',
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
