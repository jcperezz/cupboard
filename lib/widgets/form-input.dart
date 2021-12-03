import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';
import 'package:cupboard/constants/Theme.dart';
import 'package:flutter/services.dart';

class FormInput extends StatelessWidget {
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final GestureTapCallback? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final Color borderColor;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  FormInput({
    this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.borderColor = ArgonColors.border,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.initialValue,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ArgonColors.muted,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      autofocus: autofocus,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      readOnly: readOnly,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      style:
          TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
      textAlignVertical: TextAlignVertical(y: 0.6),
      decoration: InputDecoration(
          filled: true,
          fillColor: ArgonColors.white,
          hintStyle: TextStyle(
            color: ArgonColors.muted,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(
                  color: borderColor, width: 1.0, style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(
                  color: borderColor, width: 1.0, style: BorderStyle.solid)),
          hintText: Labels.of(context).getMessage(placeholder)),
    );
  }
}
