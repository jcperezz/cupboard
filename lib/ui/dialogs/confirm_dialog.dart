import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ConfirmDialog {
  final BuildContext context;
  final DialogType dialogType;
  final Function? btnOkOnPress;
  final String keyMessage;
  final List<dynamic>? args;

  ConfirmDialog(
    this.context, {
    required this.keyMessage,
    this.dialogType = DialogType.INFO,
    this.btnOkOnPress,
    this.args,
  });

  ConfirmDialog.question(
    this.context, {
    required this.keyMessage,
    this.btnOkOnPress,
    this.args,
  }) : this.dialogType = DialogType.QUESTION;

  ConfirmDialog.info(
    this.context, {
    required this.keyMessage,
    this.btnOkOnPress,
    this.args,
  }) : this.dialogType = DialogType.INFO;

  AwesomeDialog build() {
    final lb = Labels.of(context);

    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.25 : 0.75),
      dialogType: dialogType,
      animType: AnimType.BOTTOMSLIDE,
      desc: lb.getMessage(keyMessage, args),
      btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
    );
  }
}
