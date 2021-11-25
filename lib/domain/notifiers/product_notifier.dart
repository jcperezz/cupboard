import 'package:cupboard/domain/entities/product.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/domain/repositories/abstract_repository.dart';

class ProductNotifier extends ChangeNotifier {
  final String? userUid;
  final String? cupboardUid;
  late final AbstractRepository<Product> repository;

  bool isLoading = true;
  Map<String, Product> products = Map();
  Map<String, List<Product>> productsByCategory = Map();

  ProductNotifier(this.userUid, this.cupboardUid, this.repository) {
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    products = await repository.getAll(userUid);

    products.forEach((key, value) {
      String category = value.category!;

      if (!productsByCategory.containsKey(category)) {
        productsByCategory[category] = [];
      }

      productsByCategory[category]!.add(value);
    });

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(Product product) async {
    isLoading = true;
    notifyListeners();

    repository.add(product);

    isLoading = false;
    notifyListeners();
  }
}
