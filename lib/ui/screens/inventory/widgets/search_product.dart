import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/ui/screens/inventory/widgets/grid_products_widget.dart';
import 'package:cupboard/widgets/input.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final List<ProductItem> products;
  final String cupboardUid;

  const SearchBar({Key? key, required this.products, required this.cupboardUid})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final GlobalKey<ExpansionTileCardState> _expandKey = new GlobalKey();
  final TextEditingController controller = TextEditingController();

  bool _isExpanded = false;
  Labels? _labels;
  List<ProductItem> _products = [];
  String? _newProductName;

  @override
  Widget build(BuildContext context) {
    _labels = Labels.of(context);
    return SafeArea(child: _search());
  }

  Widget _search() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(33, 36, 58, 1.0),
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
      child: ExpansionTileCard(
        key: _expandKey,
        duration: const Duration(milliseconds: 600),
        initiallyExpanded: false,
        title: _buildTitle(),
        trailing: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            child: _isExpanded
                ? Icon(
                    Icons.arrow_circle_down_outlined,
                    color: Colors.red[700],
                    size: 40,
                  )
                : Icon(
                    Icons.arrow_circle_up_outlined,
                    color: Colors.green[700],
                    size: 40,
                  ),
          ),
        ),
        expandedTextColor: Colors.transparent,
        onExpansionChanged: (bool isExpanded) => setState(() {
          _isExpanded = isExpanded;
          _newProductName = null;
          _products = [];
          controller.clear();
        }),
        baseColor: Colors.transparent,
        expandedColor: Colors.transparent,
        shadowColor: Colors.transparent,
        children: [_buildExpandableBody()],
      ),
    );
  }

  Widget _buildExpandableBody() {
    return Container(
      width: double.infinity,
      height: 440,
      child: ProductsGrid(
        products: _products,
        cardColor: Colors.blue,
        newProductName: _newProductName,
        cupboardUid: widget.cupboardUid,
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      color: Colors.transparent,
      height: _isExpanded ? 55 : 110,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4, left: 15, right: 1),
        child: Input(
            placeholder: _labels!.getMessage("search_label"),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            controller: controller,
            //autofocus: widget.searchAutofocus,
            prefixIcon: Icon(Icons.search_outlined, color: ArgonColors.muted),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  _products = [];
                  _newProductName = null;
                });
                return;
              }

              final result = widget.products.where((element) =>
                  element.name.toLowerCase().startsWith(value.toLowerCase()));

              final index = result.toList().indexWhere((element) =>
                  element.name.toLowerCase() == value.toLowerCase());

              setState(() {
                _newProductName = index == -1 ? value : null;
                _products = result.toList();
              });
            },
            onTap: () {
              _expandKey.currentState!.expand();
            }),
      ),
    );
  }
}
