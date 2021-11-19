import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FireProductRepository extends AbstractRepository<Product> {
  @override
  Future<void> add(Product entity) async {
    return await getCurrentUserPath(entity.owner).push().set(entity.toMap());
  }

  @override
  Future<Map<String, Product>> getAll([String? uid]) async {
    Map<String, Product> list = Map();

    DataSnapshot snapshot = await getCurrentUserPath(uid).get();

    if (snapshot != null && snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      list = response.map(
          (key, value) => new MapEntry(key, Product.fromMap(value, id: key)));
    }

    return list;
  }

  @override
  Future<Product> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  String get path => "products";

  @override
  Future<void> populate(String uid) async {
    Map<String, Product> list = await getAll(null);

    list.forEach((key, value) {
      value.owner = uid;
      add(value);
    });
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
