import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';
import 'package:flutter/cupertino.dart';

class CategoryNotifier extends ChangeNotifier {
  final String? cupboardUid;

  late final AbstractRepository<Category> categoryRepository;

  bool isLoading = true;
  Map<String, Category> categories = Map();
  Map<String, Category> filteredCategories = Map();

  CategoryNotifier(this.cupboardUid, this.categoryRepository) {
    getCategories();
  }

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    categories = await categoryRepository.getAll(cupboardUid);

    final mapEntries = categories.entries.toList()
      ..sort((a, b) => a.value.name.compareTo(b.value.name));

    categories
      ..clear()
      ..addEntries(mapEntries);

    categories = Map.unmodifiable(categories);

    await filter();

    isLoading = false;
    notifyListeners();
  }

  filter([String? search]) {
    filteredCategories.clear();

    if (search == null || search.isEmpty) {
      filteredCategories.addAll(categories);
      return;
    }

    categories.forEach((key, value) {
      if (value.name.toLowerCase().contains(search.toLowerCase())) {
        filteredCategories[key] = value;
      }
    });

    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    isLoading = true;
    notifyListeners();
    categoryRepository.add(category);
    getCategories();
    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(Category category) async {
    isLoading = true;
    notifyListeners();
    categoryRepository.remove(category);
    getCategories();
    isLoading = false;
    notifyListeners();
  }

  Future<void> update(Category category) async {
    isLoading = true;
    notifyListeners();
    categoryRepository.update(category);
    getCategories();
    isLoading = false;
    notifyListeners();
  }
}
