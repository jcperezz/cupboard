import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocaleText extends StatelessWidget {
  final String label;
  final List<dynamic>? args;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;

  const LocaleText(this.label,
      {Key? key,
      this.args,
      this.style,
      this.maxLines,
      this.overflow,
      this.padding})
      : super(key: key);

  LocaleText.title(this.label,
      {this.args, this.maxLines, this.overflow, this.padding})
      : style = ArgonColors.title;

  LocaleText.subtitle(this.label,
      {this.args, this.maxLines, this.overflow, this.padding})
      : style = ArgonColors.titleWhite;

  LocaleText.white(this.label,
      {this.args, this.maxLines, this.overflow, this.padding})
      : style = GoogleFonts.openSans(color: Colors.white);

  LocaleText.color(this.label,
      {this.args,
      this.maxLines,
      this.overflow,
      Color color = Colors.white,
      this.padding})
      : style = GoogleFonts.openSans(color: color);

  @override
  Widget build(BuildContext context) {
    String message =
        Labels.of(context).getMessage(label, args != null ? [...args!] : []);

    final text = Text(
      message,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (padding != null) return Padding(padding: padding!, child: text);
    return text;
  }
}
