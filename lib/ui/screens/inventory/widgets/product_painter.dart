import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPainter extends CustomPainter {
  final String text;

  MyPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = GoogleFonts.londrinaShadow(
      color: Colors.white,
      fontSize: 45,
    );

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
