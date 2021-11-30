import 'dart:collection';

import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/repositories/abstract_fire_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FireProductItemRepository extends AbstractFireRepository<ProductItem> {
  @override
  Future<String> add(ProductItem entity) async {
    DatabaseReference db =
        getDb().child("cupboards/${entity.cupboardUid}").child(path).push();
    await db.set(entity.toMap());
    return db.key;
  }

  @override
  Future<Map<String, ProductItem>> getAll([String? cupboardUid]) async {
    Map<String, ProductItem> list = Map();

    DatabaseReference db = getDb().child("cupboards/$cupboardUid");
    DataSnapshot snapshot = await db.child(path).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      list = response.map((key, value) =>
          new MapEntry(key, ProductItem.fromMap(value, id: key)));
    }

    return UnmodifiableMapView(list);
  }

  @override
  Future<ProductItem> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  String get path => "inventory";

  @override
  Future<void> populate(String uid) async {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> remove(ProductItem entity) async {
    DatabaseReference db = getDb()
        .child("cupboards/${entity.cupboardUid}")
        .child("$path/${entity.id}");
    await db.remove();
  }

  @override
  Future<void> update(ProductItem entity) async {
    DatabaseReference db = getDb()
        .child("cupboards/${entity.cupboardUid}")
        .child("$path/${entity.id}");
    await db.set(entity.toMap());
  }
}
