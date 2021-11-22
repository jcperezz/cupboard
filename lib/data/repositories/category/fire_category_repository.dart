import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FireCategoryRepository extends AbstractRepository<Category> {
  @override
  Future<void> add(Category entity, [String? cupboardId]) async {
    return await getDb(entity.owner)
        .child("cupboards")
        .child(path)
        .push()
        .set(entity.toMap());
  }

  @override
  Future<Map<String, Category>> getAll([String? uid]) async {
    Map<String, Category> categories = Map();

    DataSnapshot snapshot = await getCurrentUserPath(uid).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      categories = response.map((key, value) => new MapEntry(key,
          new Category(id: key, icon: value["icon"], name: value["name"])));
    }

    return categories;
  }

  @override
  Future<Category> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> remove(Category entity) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> update(Category entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  String get path => "categories";

  @override
  Future<void> populate(String uid) async {
    Map<String, Category> categories = await getAll(null);

    categories.forEach((key, value) {
      value.owner = uid;
      add(value);
    });
  }
}
