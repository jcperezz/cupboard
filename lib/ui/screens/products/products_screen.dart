import 'dart:ui';
import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/domain/notifiers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:loading_overlay/loading_overlay.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/constants/validators.dart';
import 'package:cupboard/constants/Theme.dart';

import 'package:cupboard/widgets/button.dart';
import 'package:cupboard/widgets/form-input.dart';
import 'package:cupboard/widgets/input.dart';

import 'package:cupboard/domain/notifiers/category_notifier.dart';
import 'package:cupboard/domain/entities/category.dart';

class ProductsScreen extends StatelessWidget {
  final String cupboardId;

  const ProductsScreen({Key? key, required this.cupboardId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        _buildSafeArea(context),
        //SearchBar(),
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
    final CategoryNotifier notifier =
        Provider.of<CategoryNotifier>(context, listen: true);

    final ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: true);

    Iterable<Category> categories = notifier.categories.values;

    return LoadingOverlay(
      isLoading: notifier.isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSortingTitle(context),
            GridCategories(
              categories: categories,
              products: productNotifier.productsByCategory,
            ),
            _buildAddCategoryTitle(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSortingTitle(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.view_comfortable_rounded, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Labels.of(context).getMessage("view_options"),
                  style: ArgonColors.titleWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddCategoryTitle(BuildContext context) {
    return Container(
      height: 45,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _buildDialog(context).show(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.add, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Labels.of(context).getMessage("new_category"),
                    style: ArgonColors.titleWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AwesomeDialog _buildDialog(BuildContext context) {
    final CategoryNotifier notifier =
        Provider.of<CategoryNotifier>(context, listen: false);

    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.35 : 0.75),
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      body: _BodyDialog(service: notifier),
    );
  }
}

class _BodyDialog extends StatefulWidget {
  final CategoryNotifier service;
  const _BodyDialog({
    Key? key,
    required this.service,
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
            _buildFormButtons(context)
          ],
        ));
  }

  Widget _buildFormTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(
        child: Text(Labels.of(context).getMessage("new_category"),
            style: TextStyle(color: ArgonColors.text, fontSize: 16.0)),
      ),
    );
  }

  Widget _buildTextName(BuildContext context) {
    return _buildInputWrapper(FormInput(
      onChanged: (value) => setState(() => _name = value),
      placeholder: Labels.of(context).getMessage('category_name'),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      prefixIcon: Icon(Icons.category_rounded),
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
                if (_formKey.currentState!.validate()) {
                  Category newCategory = Category(
                    icon: "test",
                    name: _name!,
                    owner: widget.service.uid,
                  );
                  widget.service.addCategory(newCategory);
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

class GridCategories extends StatelessWidget {
  final Iterable<Category> categories;
  final Map<String, List<Product>> products;

  const GridCategories(
      {Key? key, required this.categories, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...categories.map((e) => _buildGridProducts(e)).toList()],
    );
  }

  Widget _buildGridProducts(Category category) {
    if (products[category.id] == null) return Container();

    return Column(
      children: [
        _buildCategoryTitle(category.name),
        GridViewNoViewPort(
          crossAxisCount: 5,
          childHeight: 100,
          children:
              products[category.id]!.map((e) => _buildGridTileList(e)).toList(),
        ),
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

  Widget _buildGridTileList(Product product) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Card(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: CustomPaint(
                        size: Size(40, 40),
                        painter: MyPainter(product.name.substring(0, 2)),
                        isComplex: true,
                        willChange: false,
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child:
                          Text(product.name, style: ArgonColors.titleCardWhite),
                    )
                  ],
                ),
              ),
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
  final String text;

  MyPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = GoogleFonts.londrinaShadow(
      color: Colors.white,
      fontSize: 40,
    );

    final textSpan = TextSpan(
      text: text,
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
