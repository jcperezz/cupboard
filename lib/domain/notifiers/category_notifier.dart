import 'package:cupboard/data/repositories/category/fire_category_repository.dart';
import 'package:cupboard/domain/entities/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryNotifier extends ChangeNotifier {
  final String? uid;
  late final FireCategoryRepository repository;

  bool isLoading = true;
  Map<String, Category> categories = Map();

  CategoryNotifier(this.uid) {
    repository = FireCategoryRepository();
    getCategories();
  }

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();
    categories = await repository.getAll(uid);
    isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    isLoading = true;
    notifyListeners();
    repository.add(category);
    getCategories();
    isLoading = false;
    notifyListeners();
  }
}
