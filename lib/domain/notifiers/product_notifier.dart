import 'package:cupboard/domain/entities/product.dart';
import 'package:flutter/material.dart';

import 'package:cupboard/domain/repositories/abstract_repository.dart';

class ProductNotifier extends ChangeNotifier {
  final AbstractRepository<Product> repository;

  final String? userUid;
  final String? cupboardUid;

  bool isLoading = true;
  Map<String, Product> products = Map();
  Map<String, List<Product>> productsByCategory = Map();
  List<Product> productsList = [];

  Map<String, List<Product>> filteredProductsMap = Map();
  List<Product> filteredProductsList = [];

  ProductNotifier(this.userUid, this.cupboardUid, this.repository) {
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    products = await repository.getAll(cupboardUid);
    productsByCategory.clear();
    productsList.clear();

    products.forEach((key, value) {
      String category = value.category!;

      if (!productsByCategory.containsKey(category)) {
        productsByCategory[category] = [];
      }

      productsByCategory[category]!.add(value);
      productsList.add(value);
    });

    await filterProducts();

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(Product product) async {
    isLoading = true;
    notifyListeners();
    repository.add(product);
    getAll();
    isLoading = false;
    notifyListeners();
  }

  filterProducts([String? search]) {
    filteredProductsMap.clear();
    filteredProductsList.clear();

    if (search == null || search.isEmpty) {
      filteredProductsMap.addAll(productsByCategory);
      productsByCategory.forEach((key, value) {
        filteredProductsList.addAll(value);
      });

      return;
    }

    productsByCategory.forEach((key, value) {
      final newList = <Product>[];

      value.forEach((element) {
        if (element.name.toLowerCase().contains(search.toLowerCase())) {
          newList.add(element);
        }
      });

      if (newList.isNotEmpty) {
        filteredProductsMap[key] = newList;
        filteredProductsList.addAll(newList);
      }
    });

    notifyListeners();
  }

  Future<void> delete(Product product) async {
    isLoading = true;
    notifyListeners();
    repository.remove(product);
    getAll();
    isLoading = false;
    notifyListeners();
  }

  Future<void> update(Product product) async {
    isLoading = true;
    notifyListeners();
    repository.update(product);
    getAll();
    isLoading = false;
    notifyListeners();
  }
}
