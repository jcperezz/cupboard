import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/providers/rest_api_provider.dart';
import 'package:flutter/material.dart';

class CategoriesService extends ChangeNotifier {
  bool isLoading = true;
  Map<String, Category> categories = Map();

  CategoriesService() {
    getCategories();
  }

  Future<Map<String, Category>> getCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> response =
          await RestApiProvider().get("/categories.json");

      categories = response.map((key, value) => new MapEntry(key,
          new Category(id: key, icon: value["icon"], name: value["name"])));

      isLoading = false;
      notifyListeners();

      return categories;
    } catch (e) {
      print(e);
      return Map();
    }
  }
}
