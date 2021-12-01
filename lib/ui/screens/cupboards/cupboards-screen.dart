import 'package:cupboard/ui/screens/cupboards/widgets/cupboard-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:cupboard/domain/notifiers/cupboard_notifier.dart';

import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/domain/entities/cupboard.dart';

import 'package:cupboard/constants/images.dart';
import 'package:cupboard/constants/validators.dart';
import 'package:cupboard/constants/Theme.dart';

//widgets
import 'package:cupboard/widgets/button.dart';
import 'package:cupboard/widgets/card-small.dart';
import 'package:cupboard/widgets/form-input.dart';
import 'package:cupboard/widgets/image-slider.dart';

class CupboardsScreen extends StatelessWidget {
  final String userUid;

  const CupboardsScreen({Key? key, required this.userUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPageBody(context);
  }

  Widget _buildPageBody(BuildContext context) {
    final service = Provider.of<CupboardNotifier>(context);

    return LoadingOverlay(
      child: _buildSafeArea(context),
      isLoading: service.isLoading,
    );
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: _buildGrid(context),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final service = Provider.of<CupboardNotifier>(context);

    Iterable<Cupboard> _cupboards = service.cupboards.values;
    Iterator<Cupboard> it = _cupboards.iterator;

    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(4),
      children: [
        it.moveNext()
            ? _buildCard(context, it.current)
            : _buildNewCupboard(context),
        it.moveNext()
            ? _buildCard(context, it.current)
            : _buildNewCupboard(context),
        it.moveNext()
            ? _buildCard(context, it.current)
            : _buildNewCupboard(context),
        it.moveNext()
            ? _buildCard(context, it.current)
            : _buildNewCupboard(context),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Cupboard data) {
    return CupboardCard(
      cupboard: data,
      tap: () {
        Navigator.of(context).pushNamed("/inventory/${data.id}");
      },
    );
  }

  Widget _buildNewCupboard(BuildContext context) {
    final notifier = Provider.of<CupboardNotifier>(context);
    final lb = Labels.of(context);

    return Container(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            _buildDialog(context, notifier).show();
          },
          child: Card(
            elevation: 0.4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: FittedBox(
                      child: Icon(
                        Icons.add_circle,
                        size: 200,
                        color: Colors.blue[300],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      lb.getMessage("add_cupboard"),
                      style: TextStyle(color: ArgonColors.header, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AwesomeDialog _buildDialog(BuildContext context, CupboardNotifier notifier) {
    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.35 : 0.75),
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      dialogBackgroundColor: Colors.white,
      body: _BodyDialog(notifier: notifier, userUid: userUid),
    );
  }
}

class _BodyDialog extends StatefulWidget {
  final CupboardNotifier notifier;
  final String userUid;

  const _BodyDialog({
    Key? key,
    required this.notifier,
    required this.userUid,
  }) : super(key: key);

  @override
  __BodyDialogState createState() => __BodyDialogState();
}

class __BodyDialogState extends State<_BodyDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _image;

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormTitle(context),
            _buildTextName(context),
            _buildSelectImage(context),
            _buildFormButtons(context)
          ],
        ));
  }

  Widget _buildSelectImage(BuildContext context) {
    return ImagesSlider(
      images: MyImages.cupboard_images,
      title: Labels.of(context).getMessage("select_image"),
      onTap: (value) => setState(() => _image = value),
    );
  }

  Widget _buildFormTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(
        child: Text(Labels.of(context).getMessage("new_cupboard"),
            style: TextStyle(color: ArgonColors.text, fontSize: 16.0)),
      ),
    );
  }

  Widget _buildTextName(BuildContext context) {
    return _buildInputWrapper(FormInput(
      onChanged: (value) => setState(() => _name = value),
      placeholder: Labels.of(context).getMessage('cupboard_name'),
      keyboardType: TextInputType.name,
      prefixIcon: Icon(Icons.account_balance_wallet_rounded),
      validator: (value) => Validator<String>(context, value)
          .mandatory(msg: 'mandatory_name')
          .length(min: 4, max: 32)
          .validate(),
    ));
  }

  Widget _buildInputWrapper(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }

  Widget _buildFormButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button.secondary(
              keyMessage: "cancel_label",
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(
              width: 10,
            ),
            Button.primary(
              keyMessage: "save_label",
              onPressed: () {
                if (_formKey.currentState!.validate() && _image != null) {
                  final Cupboard cupboard = new Cupboard(
                    count: 0,
                    image: _image!,
                    name: _name!,
                    owner: widget.userUid,
                  );

                  widget.notifier.add(cupboard);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
