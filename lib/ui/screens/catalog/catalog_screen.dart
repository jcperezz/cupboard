import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/ui/screens/screens.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  final String cupboardUid;

  const CatalogScreen({Key? key, required this.cupboardUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lb = Labels.of(context);
    final categoriesLabel = lb.getMessage("categories_label");
    final productsLabel = lb.getMessage("products_label");

    final List<Tab> myTabs = <Tab>[
      Tab(text: categoriesLabel),
      Tab(text: productsLabel),
    ];

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: SizedBox.shrink(),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [TabBar(tabs: myTabs)],
          ),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            final String label = tab.text!;

            if (label == categoriesLabel) {
              return CategoriesScreen(cupboardUid: cupboardUid);
            } else {
              return ProductsScreen(cupboardUid: cupboardUid);
            }
          }).toList(),
        ),
      ),
    );
  }
}
