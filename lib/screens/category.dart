import 'dart:ui';
import 'package:cupboard/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/constants/Theme.dart';

//widgets
import 'package:cupboard/widgets/input.dart';
import 'package:cupboard/widgets/navbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: "Nueva Categoría"),
        extendBodyBehindAppBar: true,
        drawer: ArgonDrawer(currentPage: "Categories"),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            buildSafeArea(context)
          ],
        ));
  }

  SafeArea buildSafeArea(BuildContext context) {
    return SafeArea(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 16, left: 24.0, right: 24.0, bottom: 32),
          child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: buildForm(context)),
        ),
      ]),
    );
  }

  Column buildForm(BuildContext context) {
    return Column(
      children: [
        buildTitle(context),
        Container(
            height: MediaQuery.of(context).size.height * 0.63,
            color: Color.fromRGBO(244, 245, 247, 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [buildFormElements(), buildFormActions(context)],
                ),
              ),
            ))
      ],
    );
  }

  Padding buildFormActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: FlatButton(
          textColor: ArgonColors.white,
          color: ArgonColors.primary,
          onPressed: () {
            // Respond to button press
            Navigator.pushNamed(context, '/home');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
              padding:
                  EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 12),
              child: Text("GUARDAR",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0))),
        ),
      ),
    );
  }

  Column buildFormElements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Input(
            placeholder: "Nombre",
            prefixIcon: Icon(Icons.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Input(placeholder: "Ícono", prefixIcon: Icon(Icons.image)),
        ),
      ],
    );
  }

  Container buildTitle(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: buildFormBackground(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Nueva Categoría",
                  style: TextStyle(color: ArgonColors.text, fontSize: 16.0)),
            )),
          ],
        ));
  }

  BoxDecoration buildFormBackground() {
    return BoxDecoration(
        color: ArgonColors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: ArgonColors.muted)));
  }
}
