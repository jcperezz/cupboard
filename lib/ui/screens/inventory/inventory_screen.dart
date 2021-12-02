import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/notifiers/product_notifier.dart';
import 'package:cupboard/ui/screens/inventory/widgets/grid_categories_widget.dart';
import 'package:cupboard/ui/screens/inventory/widgets/search_product.dart';
import 'package:cupboard/ui/widgets/empty_background.dart';
import 'package:cupboard/ui/widgets/menu_status_filter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

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

class InventoryScreen extends StatefulWidget {
  final String cupboardId;

  const InventoryScreen({Key? key, required this.cupboardId}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? _searchName;
  InventoryStatus? _searchStatus;
  int _viewOptionSeleted = 1;
  bool _isLoading = true;

  Map<String, List<ProductItem>> _filteredProductsMap = Map();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final itemState = Provider.of<ProductItemNotifier>(context);
    _isLoading = itemState.isLoading;

    if (!_isLoading) {
      _filteredProductsMap = itemState.filteredProductsMap;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productNotifier = Provider.of<ProductNotifier>(context, listen: true);

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              //_buildRail(),
              Expanded(child: _buildSafeArea(context)),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SearchBar(
            products: productNotifier.productsList,
            cupboardUid: widget.cupboardId,
          ),
        ),
      ],
    );
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        child: _buildLoadingBody(context),
      ),
    );
  }

  Widget _buildLoadingBody(BuildContext context) {
    final notifier = Provider.of<CategoryNotifier>(context);
    final categories = notifier.categories.values.toList();

    return LoadingOverlay(
      isLoading: notifier.isLoading || _isLoading,
      child: _buildBody(context, categories),
    );
  }

  Widget _buildBody(BuildContext context, List<Category> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPageTitle(context),
        _buildBodyItems(categories),
        _buildAddCategoryTitle(context),
      ],
    );
  }

  Widget _buildBodyItems(List<Category> categories) {
    if (_filteredProductsMap.isEmpty)
      return Expanded(child: EmptyBackground(keyMessage: "empty_cupboard"));

    return CategoriesProductsItemList(
      categories: categories,
      products: _filteredProductsMap,
      cupboardUid: widget.cupboardId,
    );
  }

  Widget _buildPageTitle(BuildContext context) {
    final lb = Labels.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildSearchBar(lb),
            VerticalDivider(color: ArgonColors.muted),
            _buildMenuStatuFilter(),
            //VerticalDivider(color: ArgonColors.muted),
            //_buildViewOptionsMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuStatuFilter() {
    final productNotifier = Provider.of<ProductItemNotifier>(context);

    final Map<InventoryStatus, GestureTapCallback> eventOptions = {
      InventoryStatus.all: () {
        setState(() {
          _searchStatus = null;
        });
        productNotifier.filterProducts(_searchName, _searchStatus);

        Navigator.of(context).pop();
        print("all");
      },
      InventoryStatus.close_to_expire: () {
        setState(() {
          _searchStatus = InventoryStatus.close_to_expire;
        });
        productNotifier.filterProducts(_searchName, _searchStatus);

        Navigator.of(context).pop();
        print("close_to_expire");
      },
      InventoryStatus.expired: () {
        setState(() {
          _searchStatus = InventoryStatus.expired;
        });
        productNotifier.filterProducts(_searchName, _searchStatus);
        Navigator.of(context).pop();
        print("expired");
      },
      InventoryStatus.avalaible: () {
        setState(() {
          _searchStatus = InventoryStatus.avalaible;
        });
        productNotifier.filterProducts(_searchName, _searchStatus);
        Navigator.of(context).pop();
        print("avalaible");
      },
    };

    return MenuStatusFilter(
      products: productNotifier.filteredProductsList,
      eventOptions: eventOptions,
    );
  }

  Widget _buildViewOptionsMenu() {
    final lb = Labels.of(context);

    return PopupMenuButton(
        tooltip: lb.getMessage("view_options"),
        initialValue: _viewOptionSeleted,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.view_comfortable_rounded, color: Colors.white),
          ],
        ),
        itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.view_comfortable_rounded),
                      SizedBox(width: 5),
                      Text("Tiles"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.list),
                      SizedBox(width: 5),
                      Text("List"),
                    ],
                  ),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 3,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Group items"),
                      //SizedBox(width: 5),
                      Switch(value: true, onChanged: (value) => print("tales")),
                    ],
                  ),
                ),
              ),
            ]);
  }

  Widget _buildSearchBar(Labels lb) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: Container(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: _buildSearchIconButton(),
              hintText: lb.getMessage("search_label"),
            ),
            onChanged: (String? value) {
              setState(() {
                _searchName = value;
              });
              Provider.of<ProductItemNotifier>(context, listen: false)
                  .filterProducts(_searchName, _searchStatus);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchIconButton() {
    return _searchName != null && _searchName!.length > 0
        ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                _searchName = null;
                _searchController.clear();
              });
              Provider.of<ProductItemNotifier>(context, listen: false)
                  .filterProducts(_searchName, _searchStatus);
            },
          )
        : Icon(Icons.search_outlined);
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
      dialogBackgroundColor: Colors.white,
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
