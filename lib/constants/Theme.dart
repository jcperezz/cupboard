import 'dart:collection';
import 'dart:ui' show Color;

import 'package:cupboard/domain/entities/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ArgonColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color initial = Color.fromRGBO(23, 43, 77, 1.0);

  static const Color primary = Color.fromRGBO(94, 114, 228, 1.0);

  static const Color secondary = Color.fromRGBO(247, 250, 252, 1.0);

  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);

  static const Color info = Color.fromRGBO(17, 205, 239, 1.0);

  static const Color error = Color.fromRGBO(245, 54, 92, 1.0);

  static const Color success = Color.fromRGBO(45, 206, 137, 1.0);

  static const Color warning = Color.fromRGBO(251, 99, 64, 1.0);

  static const Color header = Color.fromRGBO(82, 95, 127, 1.0);

  static const Color bgColorScreen = Color.fromRGBO(248, 249, 254, 1.0);

  static const Color border = Color.fromRGBO(202, 209, 215, 1.0);

  static const Color inputSuccess = Color.fromRGBO(123, 222, 177, 1.0);

  static const Color inputError = Color.fromRGBO(252, 179, 164, 1.0);

  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);

  static const Color text = Color.fromRGBO(50, 50, 93, 1.0);

  static const double shape_radius = 4.0;

  static const BorderRadius card_border =
      BorderRadius.all(Radius.circular(8.0));

  static TextStyle get title => GoogleFonts.openSans(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);

  static TextStyle get titleWhite =>
      GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle get titleCardWhite =>
      GoogleFonts.openSans(color: Colors.white);

  static TextStyle get expandedTitle =>
      GoogleFonts.openSans(fontWeight: FontWeight.bold);

  static TextStyle get expandedSubTitle => GoogleFonts.openSans();

  static TextStyle get titleCardProducts =>
      GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold);

  static DateFormat DATE_FORMAT_DB = DateFormat("d/M/yy");

  static final Map<InventoryStatus, Color> color_by_status =
      UnmodifiableMapView({
    InventoryStatus.all: Colors.indigo[900]!,
    InventoryStatus.pending: Colors.indigo[900]!,
    InventoryStatus.avalaible: Colors.teal[900]!,
    InventoryStatus.close_to_expire: Colors.yellow[900]!,
    InventoryStatus.expired: Colors.deepOrange[900]!,
  });
}
