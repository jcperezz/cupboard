import 'package:cupboard/domain/entities/product.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/constants/Theme.dart';

import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/entities/category.dart';

import 'package:cupboard/ui/screens/inventory/widgets/grid_products_widget.dart';
import 'package:cupboard/ui/widgets/menu_status_filter.dart';

// ignore: must_be_immutable
class CategoriesProductsItemList<T extends Product> extends StatefulWidget {
  final List<Category> categories;
  final Map<String, List<T>> products;
  final Map<String, List<T>> _productsTarget = Map();
  final bool isProductItem;
  final bool skipEmpty;
  final String cupboardUid;

  CategoriesProductsItemList({
    Key? key,
    required this.categories,
    required this.products,
    required this.cupboardUid,
    this.isProductItem = true,
    this.skipEmpty = true,
  }) : super(key: key) {
    _productsTarget.addAll(products);
  }

  @override
  _CategoriesProductsItemListState createState() =>
      _CategoriesProductsItemListState();
}

class _CategoriesProductsItemListState
    extends State<CategoriesProductsItemList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.categories
              .map((e) => _buildGridProducts(context, e))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildGridProducts(BuildContext context, Category category) {
    if (widget.skipEmpty && widget.products[category.id] == null)
      return Container();

    return ExpansionTile(
      title: _buildCategoryTitle(category),
      initiallyExpanded: widget.products[category.id] != null,
      trailing: widget.isProductItem ? _buildMenuFilter(category) : null,
      children: [
        if (widget.products[category.id] != null)
          ProductsGrid(
            products: widget._productsTarget[category.id]!,
            cupboardUid: widget.cupboardUid,
          ),
      ],
    );
  }

  Widget _buildMenuFilter(Category category) {
    final Map<InventoryStatus, GestureTapCallback> eventOptions = {
      InventoryStatus.all: () {
        _findProductsByStatus(null, null);
        Navigator.of(context).pop();
      },
      InventoryStatus.close_to_expire: () {
        _findProductsByStatus(InventoryStatus.close_to_expire, category.id);
        Navigator.of(context).pop();
      },
      InventoryStatus.expired: () {
        _findProductsByStatus(InventoryStatus.expired, category.id);
        Navigator.of(context).pop();
      },
      InventoryStatus.avalaible: () {
        _findProductsByStatus(InventoryStatus.avalaible, category.id);
        Navigator.of(context).pop();
      },
    };

    return MenuStatusFilter(
      products: (widget.products[category.id] as List<ProductItem>),
      eventOptions: eventOptions,
    );
  }

  void _findProductsByStatus(InventoryStatus? status, String? categoryId) {
    setState(() {
      widget._productsTarget.clear();
      widget._productsTarget.addAll(widget.products);

      if (status != null) {
        if (categoryId != null) {
          final productsList = <ProductItem>[];

          if (widget._productsTarget[categoryId] != null) {
            (widget._productsTarget[categoryId] as List<ProductItem>)
                .forEach((element) {
              if (element.productStatus == status) productsList.add(element);
            });
          }

          widget._productsTarget[categoryId] = productsList;
        }
      }
    });
  }

  Widget _buildCategoryTitle(Category category) {
    final lb = Labels.of(context);
    final productList = widget._productsTarget[category.id];

    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Container(
                child: Text("${category.name}",
                    style: ArgonColors.expandedTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              productList == null
                  ? lb.getMessage("empty_label")
                  : lb.getMessage("count_item_label", [productList.length]),
              style: ArgonColors.expandedSubTitle,
            ),
          ),

          //VerticalDivider(),
        ],
      ),
    );
  }
}
