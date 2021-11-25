import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/entities/cupboard.dart';
import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';
import 'package:flutter/material.dart';

class CupboardNotifier extends ChangeNotifier {
  final AbstractRepository<Cupboard> cupboardRepository;
  final AbstractRepository<Category> categoryRepository;
  final AbstractRepository<Product> productRepository;

  final String userUid;

  bool isLoading = true;
  Map<String, Cupboard> cupboards = Map();

  CupboardNotifier(this.userUid, this.cupboardRepository,
      this.categoryRepository, this.productRepository) {
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    cupboards = await this.cupboardRepository.getAll(this.userUid);
    isLoading = false;
    notifyListeners();
  }

  Future<void> add(Cupboard cupboard) async {
    isLoading = true;
    notifyListeners();
    String parentUid = await cupboardRepository.add(cupboard);
    await categoryRepository.populate(parentUid);
    await productRepository.populate(parentUid);
    await getAll();
  }
}
