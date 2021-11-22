import 'package:cupboard/data/repositories/category/fire_category_repository.dart';
import 'package:cupboard/domain/entities/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryNotifier extends ChangeNotifier {
  final String? uid;
  final String? cupboardUid;

  late final FireCategoryRepository repository;

  bool isLoading = true;
  Map<String, Category> categories = Map();

  CategoryNotifier(this.uid, this.cupboardUid) {
    repository = FireCategoryRepository();
    getCategories();
  }

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    Map<String, Category> generalCategories = await repository.getAll();
    Map<String, Category> categoriesByUser = await repository.getAll(uid);

    categories.addAll(generalCategories);
    categories.addAll(categoriesByUser);

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
