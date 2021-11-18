import 'dart:ui';
import 'package:cupboard/constants/icons.dart';
import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/services/categories_service.dart';
import 'package:cupboard/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/constants/Theme.dart';

//widgets
import 'package:cupboard/widgets/input.dart';
import 'package:cupboard/widgets/navbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: "Categorías"),
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
            _buildSafeArea(context)
          ],
        ));
  }

  Widget _buildSafeArea(BuildContext context) {
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

  Widget buildForm(BuildContext context) {
    return Column(
      children: [
        buildPageTitle(context),
        Container(
          height: MediaQuery.of(context).size.height * 0.63,
          color: Color.fromRGBO(244, 245, 247, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: _buildGrid(context)),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: true);

    Iterable<Category> categories = categoriesService.categories.values;

    return GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: categories.map((e) => _buildGridTileList(e)).toList(),
    );
  }

  Widget _buildGridTileList(Category cat) {
    return Card(
      elevation: 0.4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Icon(MyIcons.fromString(cat.icon), size: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(cat.name,
                      style:
                          TextStyle(color: ArgonColors.header, fontSize: 20)),
                )
              ],
            ),
          ),
        ),
      ),
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
              child: Text("REGISTER",
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
            placeholder: "Name",
            prefixIcon: Icon(Icons.school),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Input(placeholder: "Email", prefixIcon: Icon(Icons.email)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Input(placeholder: "Password", prefixIcon: Icon(Icons.lock)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: RichText(
              text: TextSpan(
                  text: "password strength: ",
                  style: TextStyle(color: ArgonColors.muted),
                  children: [
                TextSpan(
                    text: "strong",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ArgonColors.success))
              ])),
        ),
      ],
    );
  }

  Container buildPageTitle(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            color: ArgonColors.white,
            border: Border(
                bottom: BorderSide(width: 0.5, color: ArgonColors.muted))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Lista de Categorías",
                  style: TextStyle(color: ArgonColors.text, fontSize: 16.0)),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // width: 0,
                    height: 36,
                    child: RaisedButton(
                        textColor: ArgonColors.primary,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushNamed(context, "/new-category");
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, top: 10, left: 14, right: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(FontAwesomeIcons.accessibleIcon, size: 13),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("AGREGAR",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13))
                              ],
                            ))),
                  ),
                ],
              ),
            ),
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
