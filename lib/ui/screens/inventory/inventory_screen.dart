import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/notifiers/product_notifier.dart';
import 'package:cupboard/ui/screens/inventory/widgets/grid_categories_widget.dart';
import 'package:cupboard/ui/screens/inventory/widgets/search_product.dart';
import 'package:cupboard/ui/widgets/empty_background.dart';
import 'package:cupboard/ui/widgets/menu_status_filter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/constants/Theme.dart';

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
        //_buildAddCategoryTitle(context),
      ],
    );
  }

  Widget _buildBodyItems(List<Category> categories) {
    if (_filteredProductsMap.isEmpty)
      return Expanded(child: EmptyBackground(keyMessage: "empty_cupboard"));

    return CategoriesProductsItemList<ProductItem>(
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
}
