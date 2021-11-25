import 'package:cupboard/ui/screens/inventory/widgets/grid_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cupboard/constants/Theme.dart';

import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/entities/product_item.dart';

class CategoriesList extends StatelessWidget {
  final Iterable<Category> categories;
  final Map<String, List<ProductItem>> products;
  final String cupboardUid;

  const CategoriesList(
      {Key? key,
      required this.categories,
      required this.products,
      required this.cupboardUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((e) => _buildGridProducts(context, e)).toList(),
    );
  }

  Widget _buildGridProducts(BuildContext context, Category category) {
    if (products[category.id] == null) return Container();
    return ExpansionTile(
      title: _buildCategoryTitle(category.name),
      initiallyExpanded: true,
      children: [
        ProductsGrid(products: products[category.id]!),
      ],
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: ArgonColors.titleCardWhite),
          ),
          Row(
            children: [
              Text("+99", style: ArgonColors.titleCardWhite),
              IconButton(
                  onPressed: () => print("funciona 1"),
                  icon: Icon(Icons.warning, color: Colors.red)),
              VerticalDivider(),
              Text("+5", style: ArgonColors.titleCardWhite),
              IconButton(
                  onPressed: () => print("funciona 2"),
                  icon: Icon(FontAwesomeIcons.adn, color: Colors.amber)),
              VerticalDivider(),
              Text("+5", style: ArgonColors.titleCardWhite),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.check_circle, color: Colors.green)),
              VerticalDivider(),
            ],
          )
        ],
      ),
    );
  }
}
