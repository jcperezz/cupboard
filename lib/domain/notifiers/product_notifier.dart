import 'package:cupboard/data/repositories/product/fire_product_repository.dart';
import 'package:cupboard/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  final String? uid;
  late final FireProductRepository repository;
  bool isLoading = true;
  Map<String, Product> products = Map();
  Map<String, List<Product>> productsByCategory = Map();

  ProductNotifier(this.uid) {
    repository = FireProductRepository();
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    products = await repository.getAll(uid);

    products.forEach((key, value) {
      String category = value.category;

      if (!productsByCategory.containsKey(category)) {
        productsByCategory[category] = [];
      }

      productsByCategory[category]!.add(value);
    });

    print("$products");
    print("$productsByCategory");

    isLoading = false;
    notifyListeners();
  }
}
