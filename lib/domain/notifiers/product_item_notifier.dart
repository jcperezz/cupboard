import 'package:flutter/material.dart';

import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';

class ProductItemNotifier extends ChangeNotifier {
  final String? userUid;
  final String? cupboardUid;
  late final AbstractRepository<ProductItem> productItemRepository;

  bool isLoading = true;
  Map<String, ProductItem> products = Map();
  Map<String, List<ProductItem>> productsByCategory = Map();

  ProductItemNotifier(
      this.userUid, this.cupboardUid, this.productItemRepository) {
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    products = await productItemRepository.getAll(userUid);

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

  Future<void> add(ProductItem product) async {
    isLoading = true;
    notifyListeners();

    productItemRepository.add(product);

    isLoading = false;
    notifyListeners();
  }
}
