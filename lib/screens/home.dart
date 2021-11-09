import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cupboard/constants/images.dart';
import 'package:cupboard/constants/validators.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/models/cupboard.dart';
import 'package:cupboard/services/cupboards_service.dart';
import 'package:cupboard/services/notifications_service.dart';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:provider/provider.dart';

import 'package:cupboard/constants/Theme.dart';

//widgets
import 'package:cupboard/widgets/navbar.dart';
import 'package:cupboard/widgets/drawer.dart';
import 'package:cupboard/widgets/button.dart';
import 'package:cupboard/widgets/card-small.dart';
import 'package:cupboard/widgets/form-input.dart';
import 'package:cupboard/widgets/image-slider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Labels _labels = Labels.of(context);

    return Scaffold(
      appBar: Navbar(
        transparent: true,
        title: _labels.getMessage("cupboard_page_title"),
        searchBar: true,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: ArgonColors.bgColorScreen,
      drawer:
          ArgonDrawer(currentPage: _labels.getMessage("cupboard_page_title")),
      body: LoadingOverlay(
        isLoading: Provider.of<CupboardsService>(context).isLoading,
        child: _buildScaffoldBody(context),
      ),
    );
  }

  Stack _buildScaffoldBody(BuildContext context) {
    return Stack(
      children: [
        buildBackground(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: _buildBody(context),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final CupboardsService service = Provider.of<CupboardsService>(context);
    Iterable<Cupboard> _cupboards = service.cupboards.values;
    Iterator<Cupboard> it = _cupboards.iterator;

    return Column(
      children: <Widget>[
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            it.moveNext()
                ? _buildCard(context, it.current)
                : _buildNewCupboard(context),
            it.moveNext()
                ? _buildCard(context, it.current)
                : _buildNewCupboard(context),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            it.moveNext()
                ? _buildCard(context, it.current)
                : _buildNewCupboard(context),
            it.moveNext()
                ? _buildCard(context, it.current)
                : _buildNewCupboard(context),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Cupboard data) {
    return CardSmall(
        cta: "Ver productos",
        title: data.name,
        image: AssetImage("assets/img/${data.image}"),
        tap: () {
          //Navigator.pushNamed(context, status.navigationName);
        });
  }

  Widget _buildNewCupboard(BuildContext context) {
    return Flexible(
        child: Container(
      height: 310,
      child: GestureDetector(
        onTap: () {
          print("funciona");

          _buildDialog(context).show();
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
                  child: Icon(
                    Icons.add_circle,
                    size: 250,
                    color: Colors.blue[300],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                  "<Agregar Alacena>",
                  style: TextStyle(
                    color: ArgonColors.header,
                    fontSize: 20,
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    ));
  }

  AwesomeDialog _buildDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width * 0.75,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      body: _BodyDialog(),
      // btnCancelOnPress: () {},
      // btnOkText: "GUARDAR",
      // btnCancelText: "CANCELAR",
      // btnOkColor: Colors.blue,
      // btnOkOnPress: () {},
    );
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage("assets/img/register-bg.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _BodyDialog extends StatefulWidget {
  const _BodyDialog({
    Key? key,
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
            _buildSelectImage(),
            _buildFormButtons(context)
          ],
        ));
  }

  ImagesSlider _buildSelectImage() {
    return ImagesSlider(
      images: MyImages.cupboard_images,
      title: 'Seleccione una imagen',
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
      validator: (value) => Validator<String>(value)
          .mandatory(msg: Labels.of(context).getMessage('mandatory_name'))
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
    final service = Provider.of<CupboardsService>(context);

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
                  service.add(
                      new Cupboard(count: "0", image: _image!, name: _name!));
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
