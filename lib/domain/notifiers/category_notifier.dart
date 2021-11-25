import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';
import 'package:flutter/cupertino.dart';

class CategoryNotifier extends ChangeNotifier {
  final String? uid;
  final String? cupboardUid;

  late final AbstractRepository<Category> categoryRepository;

  bool isLoading = true;
  Map<String, Category> categories = Map();

  CategoryNotifier(this.uid, this.cupboardUid, this.categoryRepository) {
    getCategories();
  }

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    categories = await categoryRepository.getAll(cupboardUid);

    isLoading = false;
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
}
