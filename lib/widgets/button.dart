import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String keyMessage;
  final Color? primary;
  final Color? textColor;
  final IconData? icon;

  const Button({
    Key? key,
    this.onPressed,
    required this.keyMessage,
    this.primary,
    this.textColor,
    this.icon,
  }) : super(key: key);

  const Button.primary(
      {required String keyMessage, VoidCallback? onPressed, IconData? icon})
      : this(
          keyMessage: keyMessage,
          onPressed: onPressed,
          primary: ArgonColors.primary,
          textColor: ArgonColors.white,
          icon: icon,
        );

  const Button.secondary(
      {required String keyMessage, VoidCallback? onPressed, IconData? icon})
      : this(
          keyMessage: keyMessage,
          onPressed: onPressed,
          primary: ArgonColors.secondary,
          textColor: ArgonColors.primary,
          icon: icon,
        );

  const Button.important(
      {required String keyMessage, VoidCallback? onPressed, IconData? icon})
      : this(
          keyMessage: keyMessage,
          onPressed: onPressed,
          primary: Colors.redAccent,
          textColor: ArgonColors.white,
          icon: icon,
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ArgonColors.shape_radius)),
      ),
      onPressed: onPressed,
      child: Padding(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(FontAwesomeIcons.github, size: 13),
              if (icon != null) SizedBox(width: 5),
              Text(Labels.of(context).getMessage(keyMessage),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: textColor)),
            ],
          )),
    );
  }
}
