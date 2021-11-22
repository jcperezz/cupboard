import 'package:cupboard/data/repositories/product/fire_product_repository.dart';
import 'package:cupboard/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  final String? userUid;
  final String? cupboardUid;

  late final FireProductRepository repository;
  bool isLoading = true;
  Map<String, Product> products = Map();
  Map<String, List<Product>> productsByCategory = Map();

  ProductNotifier(this.userUid, this.cupboardUid) {
    repository = FireProductRepository();
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    Map<String, Product> generalProducts = await repository.getAll();
    Map<String, Product> productsByUser =
        await repository.getAll(userUid, cupboardUid);

    products.addAll(generalProducts);
    products.addAll(productsByUser);

    products.forEach((key, value) {
      String category = value.category;

      if (!productsByCategory.containsKey(category)) {
        productsByCategory[category] = [];
      }

      productsByCategory[category]!.add(value);
    });

    isLoading = false;
    notifyListeners();
  }
}
