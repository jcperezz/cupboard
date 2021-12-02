import 'package:cupboard/constants/images.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyBackground extends StatelessWidget {
  final String keyMessage;

  const EmptyBackground({
    Key? key,
    required this.keyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MyImages.empty_image,
                    ),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  Labels.of(context).getMessage(keyMessage),
                  style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 65,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
