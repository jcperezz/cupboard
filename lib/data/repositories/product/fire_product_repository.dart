import 'dart:collection';

import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/domain/repositories/abstract_fire_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FireProductRepository extends AbstractFireRepository<Product> {
  @override
  Future<String> add(Product entity) async {
    final DatabaseReference db = getDb();
    db.child("cupboards/${entity.cupboardUid}").child(path).push();
    await db.set(entity.toMap());

    return "";
  }

  @override
  Future<Map<String, Product>> getAll([String? parentUid]) async {
    Map<String, Product> list = Map();

    DataSnapshot snapshot = parentUid == null
        ? await getDb().child(path).get()
        : await getDb().child("cupboards/$parentUid").child(path).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;

      response.forEach((key, value) {
        print("$value");
        list[key] = Product.fromMap(key, value);
      });
    }

    return list;
  }

  @override
  Future<Product?> getById(String id) {
    throw UnimplementedError();
  }

  @override
  String get path => "products";

  @override
  Future<void> populate(String parentUid) async {
    DataSnapshot snapshot = await getDb().child(path).get();
    final DatabaseReference db = getDb().child("cupboards/$parentUid");

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      db.child(path).set(response);
    }
  }

  @override
  Future<void> remove(Product entity) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> update(Product entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
