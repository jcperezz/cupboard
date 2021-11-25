import 'package:cupboard/ui/screens/inventory/widgets/grid_categories_widget.dart';
import 'package:cupboard/ui/screens/inventory/widgets/search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:loading_overlay/loading_overlay.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/constants/validators.dart';
import 'package:cupboard/constants/Theme.dart';

import 'package:cupboard/widgets/button.dart';
import 'package:cupboard/widgets/form-input.dart';

import 'package:cupboard/domain/notifiers/product_item_notifier.dart';
import 'package:cupboard/domain/notifiers/category_notifier.dart';
import 'package:cupboard/domain/entities/category.dart';

class InventoryScreen extends StatelessWidget {
  final String cupboardId;

  const InventoryScreen({Key? key, required this.cupboardId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductItemNotifier productNotifier =
        Provider.of<ProductItemNotifier>(context, listen: true);

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Align(alignment: Alignment.topCenter, child: _buildSafeArea(context)),
        Align(
            alignment: Alignment.bottomCenter,
            child: SearchBar(
              products: productNotifier.products.values.toList(),
              cupboardUid: cupboardId,
            )),
      ],
    );
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8, left: 24.0, right: 24.0, bottom: 120),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final CategoryNotifier notifier =
        Provider.of<CategoryNotifier>(context, listen: true);

    final ProductItemNotifier productNotifier =
        Provider.of<ProductItemNotifier>(context, listen: true);

    Iterable<Category> categories = notifier.categories.values;

    return LoadingOverlay(
      isLoading: notifier.isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSortingTitle(context),
            CategoriesList(
              categories: categories,
              products: productNotifier.productsByCategory,
              cupboardUid: cupboardId,
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
                if (_formKey.currentState!.validate()) {
                  Category newCategory = Category(
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
