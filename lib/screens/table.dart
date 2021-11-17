import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/providers/firebase_database_provider.dart';
import 'package:cupboard/widgets/input.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:cupboard/constants/icons.dart';
import 'package:cupboard/models/category.dart';
import 'package:cupboard/services/categories_service.dart';

import 'package:google_fonts/google_fonts.dart';

//widgets

import 'package:provider/provider.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FireDbProvider fire = FireDbProvider();
    fire.prueba();

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        _buildSafeArea(context),
        SearchBar(),
      ],
    );
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8, left: 24.0, right: 24.0, bottom: 32),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: true);

    Iterable<Category> categories = categoriesService.categories.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSortingTitle(),
        GridCategories(categories: categories),
      ],
    );
  }

  Widget _buildCategoryList(Iterable<Category> categories) {
    return Column(
      children: [
        Column(
          children: categories.map((e) => _buildTileList(e)).toList(),
        ),
      ],
    );
  }

  Widget _buildGridProducts(Iterable<Category> categories) {
    return Column(
      children: [
        _buildCategoryTitle("frutas"),
        GridViewNoViewPort(
          crossAxisCount: 5,
          childHeight: 100,
          children: categories.map((e) => _buildGridTileList(e)).toList(),
        ),
      ],
    );
  }

  Widget _buildSortingTitle() {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.sort_by_alpha_rounded, color: Colors.white),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Sorting", style: ArgonColors.titleWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: ArgonColors.titleWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildTileList(Category cat) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey[600],
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cat.name,
                style: GoogleFonts.openSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(child: Container()),
            Icon(
              Icons.navigate_next_sharp,
              color: Colors.white,
              size: 45,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGridTileList(Category cat) {
    return Card(
      margin: EdgeInsets.all(1),
      color: Colors.red,
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
/*                 Icon(
                  MyIcons.fromString(cat.icon),
                  size: 40,
                  color: Colors.white,
                ), */

                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: CustomPaint(
                    size: Size(40, 40),
                    painter: MyPainter(),
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(cat.name, style: ArgonColors.titleCardWhite),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListViewNoViewPort extends StatelessWidget {
  final List<Widget> children;
  const ListViewNoViewPort({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GridCategories extends StatelessWidget {
  final Iterable<Category> categories;

  const GridCategories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((e) => _buildGridProducts(e)).toList(),
    );
  }

  Widget _buildGridProducts(Category category) {
    return Column(
      children: [
        _buildCategoryTitle(category.name),
        // GridViewNoViewPort(
        //   crossAxisCount: 5,
        //   childHeight: 100,
        //   children: categories.map((e) => _buildGridTileList(e)).toList(),
        // ),
      ],
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: ArgonColors.titleWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildGridTileList(Category cat) {
    return Card(
      margin: EdgeInsets.all(1),
      color: Colors.red,
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
/*                 Icon(
                  MyIcons.fromString(cat.icon),
                  size: 40,
                  color: Colors.white,
                ), */

                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: CustomPaint(
                    size: Size(40, 40),
                    painter: MyPainter(),
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(cat.name, style: ArgonColors.titleCardWhite),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridViewNoViewPort extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double childHeight;

  const GridViewNoViewPort(
      {Key? key,
      required this.children,
      required this.crossAxisCount,
      required this.childHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            ..._buildRows(),
          ],
        )
      ],
    );
  }

  List<Widget> _buildRows() {
    List<Widget> rows = [];
    List<Widget> subList = [];

    for (var i = 0; i < children.length; i++) {
      subList.add(_buildWrapper(children[i]));

      if (i > 0 && i % crossAxisCount == 0) {
        rows.add(Row(
          children: [...subList],
        ));
        subList = [];
      }
    }

    if (subList.isNotEmpty) {
      while (subList.length < crossAxisCount) {
        subList.add(_buildWrapper(Container()));
      }

      rows.add(Row(
        children: [...subList],
      ));
    }

    return rows;
  }

  Widget _buildWrapper(Widget child) {
    return Expanded(
      child: Container(
        height: childHeight,
        child: child,
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _search();
  }

  Container _search() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey[600],
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4, left: 15, right: 15),
        child: Input(
            placeholder: "What are you looking for?",
            //controller: widget.searchController,
            //onChanged: (String arg) => widget.searchOnChanged,
            //autofocus: widget.searchAutofocus,
            prefixIcon: Icon(Icons.search_outlined, color: ArgonColors.muted),
            onTap: () {
              //Navigator.pushNamed(context, '/pro');
            }),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = GoogleFonts.londrinaShadow(
      color: Colors.white,
      fontSize: 70,
    );

    final textSpan = TextSpan(
      text: 'H',
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
