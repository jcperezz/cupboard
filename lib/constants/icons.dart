import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyIcons {
  static IconData fromString(String name) {
    switch (name) {
      case ("bebidas.png"):
        return FontAwesomeIcons.apple;
      default:
        return Icons.ac_unit;
    }
  }
}
