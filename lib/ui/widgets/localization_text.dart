import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';

class LocaleText extends StatelessWidget {
  final String label;
  final List<dynamic>? args;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const LocaleText(this.label,
      {Key? key, this.args, this.style, this.maxLines, this.overflow})
      : super(key: key);

  LocaleText.title(this.label, {this.args, this.maxLines, this.overflow})
      : style = ArgonColors.title;

  @override
  Widget build(BuildContext context) {
    String message =
        Labels.of(context).getMessage(label, args != null ? [...args!] : []);

    return Text(
      message,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
