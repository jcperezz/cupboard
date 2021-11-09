import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';

class MyTemplate extends TemplateBlueRocket {
  final BeautifulPopup options;
  MyTemplate(this.options) : super(options);

  @override
  Color get primaryColor => Colors.blue;
}
