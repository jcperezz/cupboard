import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuStatusFilter extends StatefulWidget {
  final List<ProductItem>? products;
  final Map<InventoryStatus, GestureTapCallback?>? eventOptions;

  MenuStatusFilter({Key? key, this.products, this.eventOptions})
      : super(key: key);

  @override
  _MenuStatusFilterState createState() => _MenuStatusFilterState();
}

class _MenuStatusFilterState extends State<MenuStatusFilter> {
  int _popupOptionSelected = 1;

  @override
  Widget build(BuildContext context) {
    final statusCount = _getInventoryStatusCount(widget.products);

    return _buildStatusMenu(statusCount);
  }

  Widget _buildStatusMenu(Map<InventoryStatus, int> statusCount) {
    final lb = Labels.of(context);

    return PopupMenuButton(
        enabled: statusCount.length > 0,
        tooltip: lb.getMessage("filter_by_label"),
        initialValue: _popupOptionSelected,
        icon: Icon(Icons.filter_list_rounded),
        itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _popupOptionSelected = 1;
                    });

                    if (widget.eventOptions != null &&
                        widget.eventOptions![InventoryStatus.all] != null)
                      widget.eventOptions![InventoryStatus.all]!();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.info,
                          color: ArgonColors
                              .color_by_status[InventoryStatus.pending]),
                      SizedBox(width: 5),
                      Text(lb.getMessage(
                          "show_all", [statusCount[InventoryStatus.all]])),
                    ],
                  ),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    _popupOptionSelected = 2;

                    if (widget.eventOptions != null &&
                        widget.eventOptions![InventoryStatus.expired] != null)
                      widget.eventOptions![InventoryStatus.expired]!();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.info,
                          color: ArgonColors
                              .color_by_status[InventoryStatus.expired]),
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
                    _popupOptionSelected = 3;

                    if (widget.eventOptions != null &&
                        widget.eventOptions![InventoryStatus.close_to_expire] !=
                            null)
                      widget.eventOptions![InventoryStatus.close_to_expire]!();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.info,
                          color: ArgonColors.color_by_status[
                              InventoryStatus.close_to_expire]),
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
                    _popupOptionSelected = 4;

                    if (widget.eventOptions != null &&
                        widget.eventOptions![InventoryStatus.avalaible] != null)
                      widget.eventOptions![InventoryStatus.avalaible]!();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.info,
                          color: ArgonColors
                              .color_by_status[InventoryStatus.avalaible]),
                      SizedBox(width: 5),
                      Text(lb.getMessage("avalaible_option",
                          [statusCount[InventoryStatus.avalaible]])),
                    ],
                  ),
                ),
              ),
            ]);
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
}
