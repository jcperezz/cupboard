import 'package:cupboard/domain/entities/product.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';

class ProductItemNotifier extends ChangeNotifier {
  final AbstractRepository<ProductItem> productItemRepository;
  final AbstractRepository<Product> productRepository;

  final String? userUid;
  final String? cupboardUid;

  bool isLoading = true;
  Map<String, ProductItem> products = Map();
  Map<String, List<ProductItem>> productsByCategory = Map();

  ProductItemNotifier(this.userUid, this.cupboardUid,
      this.productItemRepository, this.productRepository) {
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    products = await productItemRepository.getAll(cupboardUid);

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

    await productItemRepository.add(product);
    //productRepository.add(product); TODO agregar al catalogo evitando duplicados

    isLoading = false;
    notifyListeners();
  }

  Future<void> update(ProductItem product) async {
    isLoading = true;
    notifyListeners();
    await productItemRepository.update(product);
    isLoading = false;
    notifyListeners();
  }

  Future<void> remove(ProductItem product) async {
    isLoading = true;
    notifyListeners();
    await productItemRepository.remove(product);
    await getAll();
  }
}
