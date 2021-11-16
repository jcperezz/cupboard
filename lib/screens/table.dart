import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cupboard/constants/icons.dart';
import 'package:cupboard/models/category.dart';
import 'package:cupboard/services/categories_service.dart';

import 'package:cupboard/constants/Theme.dart';

//widgets

import 'package:provider/provider.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSafeArea(context);
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, left: 24.0, right: 24.0, bottom: 32),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        //_buildPageTitle(context),
        Container(
          //height: MediaQuery.of(context).size.height * 0.63,
          color: Colors.transparent,
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

  Container _buildPageTitle(BuildContext context) {
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
}
