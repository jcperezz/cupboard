import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/entities/category.dart';

import 'package:cupboard/ui/screens/inventory/widgets/grid_products_widget.dart';

import 'package:cupboard/constants/Theme.dart';

// ignore: must_be_immutable
class CategoriesProductsItemList extends StatefulWidget {
  final List<Category> categories;
  final Map<String, List<ProductItem>> products;
  late Map<String, List<ProductItem>> _productsTarget;
  final String cupboardUid;

  CategoriesProductsItemList(
      {Key? key,
      required this.categories,
      required this.products,
      required this.cupboardUid})
      : super(key: key) {
    _productsTarget = this.products;
  }

  @override
  _CategoriesProductsItemListState createState() =>
      _CategoriesProductsItemListState();
}

class _CategoriesProductsItemListState
    extends State<CategoriesProductsItemList> {
  int _popupOptionSelected = 1;

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
    //if (widget.products[category.id] == null) return Container();

    final statusCount = _getInventoryStatusCount(widget.products[category.id]);

    return ExpansionTile(
      title: _buildCategoryTitle(category),
      initiallyExpanded: widget.products[category.id] != null,
      trailing: _buildStatusMenu(statusCount, category),
      children: [
        if (widget.products[category.id] != null)
          ProductsGrid(
            products: widget._productsTarget[category.id]!,
            cupboardUid: widget.cupboardUid,
          ),
      ],
    );
  }

  Map<InventoryStatus, int> _getInventoryStatusCount(
      List<ProductItem>? products) {
    final counts = Map<InventoryStatus, int>();
    if (products == null) return counts;

    counts[InventoryStatus.avalaible] = 0;
    counts[InventoryStatus.close_to_expire] = 0;
    counts[InventoryStatus.expired] = 0;
    counts[InventoryStatus.all] = products.length;

    products.forEach((element) {
      switch (element.productStatus) {
        case InventoryStatus.close_to_expire:
          counts[InventoryStatus.close_to_expire] =
              counts[InventoryStatus.close_to_expire]! + 1;
          break;
        case InventoryStatus.expired:
          counts[InventoryStatus.expired] =
              counts[InventoryStatus.expired]! + 1;
          break;
        default:
          counts[InventoryStatus.avalaible] =
              counts[InventoryStatus.avalaible]! + 1;
      }
    });

    return counts;
  }

  void _findProductsByStatus(InventoryStatus? status, String? categoryId) {
    setState(() {
      if (status == null) {
        widget._productsTarget = widget.products;
      } else {
        widget._productsTarget = widget.products.map((key, value) => MapEntry(
            key,
            value
                .where((element) =>
                    (categoryId == null || (key == categoryId)) &&
                    element.productStatus == status)
                .toList()));
      }
    });
  }

  Widget _buildCategoryTitle(Category category) {
    final lb = Labels.of(context);
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 300,
            child: Text("${category.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: ArgonColors.expandedTitle),
          ),
          if (widget._productsTarget[category.id] == null)
            Text(lb.getMessage("empty_label"),
                style: ArgonColors.expandedSubTitle),
          if (widget._productsTarget[category.id] != null)
            Text(
                lb.getMessage("count_item_label",
                    [widget._productsTarget[category.id]!.length]),
                style: ArgonColors.expandedSubTitle),
          VerticalDivider(),
        ],
      ),
    );
  }

  Widget _buildStatusMenu(
      Map<InventoryStatus, int> statusCount, Category category) {
    final lb = Labels.of(context);

    return PopupMenuButton(
        enabled: statusCount.length > 0,
        tooltip: lb.getMessage("filter_by_label"),
        initialValue: _popupOptionSelected,
        icon: Icon(Icons.filter_list_rounded),
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    _findProductsByStatus(null, null);
                    _popupOptionSelected = 1;
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.all_inbox_rounded),
                      SizedBox(width: 5),
                      Text(lb.getMessage(
                          "show_all", [statusCount[InventoryStatus.all]])),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    _findProductsByStatus(InventoryStatus.expired, category.id);
                    _popupOptionSelected = 2;
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.warning, color: Colors.red),
                      SizedBox(width: 5),
                      Text(lb.getMessage("expired_option",
                          [statusCount[InventoryStatus.expired]])),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: GestureDetector(
                  onTap: () {
                    _findProductsByStatus(
                        InventoryStatus.close_to_expire, category.id);
                    _popupOptionSelected = 3;
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.warning, color: Colors.yellow),
                      SizedBox(width: 5),
                      Text(lb.getMessage("close_to_expire_option",
                          [statusCount[InventoryStatus.close_to_expire]])),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: GestureDetector(
                  onTap: () {
                    _findProductsByStatus(
                        InventoryStatus.avalaible, category.id);
                    _popupOptionSelected = 4;
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.info, color: Colors.green),
                      SizedBox(width: 5),
                      Text(lb.getMessage("avalaible_option",
                          [statusCount[InventoryStatus.avalaible]])),
                    ],
                  ),
                ),
              ),
            ]);
  }
}
