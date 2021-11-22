import 'package:cupboard/domain/entities/cupboard.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';
import 'package:flutter/material.dart';

class CupboardNotifier extends ChangeNotifier {
  late final AbstractRepository<Cupboard> repository;

  bool isLoading = true;
  Map<String, Cupboard> cupboards = Map();

  CupboardNotifier(this.repository) {
    getAll();
  }

  Future<void> getAll() async {
    isLoading = true;
    notifyListeners();
    cupboards = await repository.getAll();
    print("aca $cupboards");
    isLoading = false;
    notifyListeners();
  }

  Future<void> add(Cupboard cupboard) async {
    isLoading = true;
    notifyListeners();
    await repository.add(cupboard);
    await getAll();
  }
}
