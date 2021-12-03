import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/services/notifications_service.dart';
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
  Map<String, List<ProductItem>> filteredProductsMap = Map();

  List<ProductItem> productsList = [];
  List<ProductItem> filteredProductsList = [];

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
      productsList.add(value);
    });

    await filterProducts();

    isLoading = false;
    notifyListeners();
  }

  filterProducts([String? search, InventoryStatus? status]) {
    filteredProductsMap.clear();
    filteredProductsList.clear();

    if ((search == null || search.isEmpty) && status == null) {
      filteredProductsMap.addAll(productsByCategory);
      productsByCategory.forEach((key, value) {
        filteredProductsList.addAll(value);
      });

      return;
    }

    productsByCategory.forEach((key, value) {
      final newList = <ProductItem>[];

      value.forEach((element) {
        bool isNameOk = true;
        if (search != null && search.isNotEmpty)
          isNameOk = element.name.toLowerCase().contains(search.toLowerCase());

        bool isStatusOk = true;
        if (status != null) isStatusOk = element.productStatus == status;

        if (isNameOk && isStatusOk) {
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

  Future<void> add(ProductItem product) async {
    isLoading = true;
    notifyListeners();

    await productItemRepository.add(product);
    productRepository.add(Product.fromItem(
        product)); //TODO agregar al catalogo evitando duplicados

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

  Future<void> remove(ProductItem product, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await productItemRepository.remove(product);
    await getAll();
    final lb = Labels.of(context);
    NotificationsService.showSnackbar(lb.getMessage("delete_successful"));
  }
}
