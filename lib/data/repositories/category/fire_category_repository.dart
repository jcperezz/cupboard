import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/repositories/abstract_fire_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FireCategoryRepository extends AbstractFireRepository<Category> {
  @override
  Future<String> add(Category entity) async {
    final DatabaseReference db = getDb();
    await db
        .child("cupboards/${entity.cupboardUid}")
        .child(path)
        .push()
        .set(entity.toMap());
    return "";
  }

  @override
  Future<Map<String, Category>> getAll([String? cupboardUid]) async {
    Map<String, Category> categories = Map();

    DataSnapshot snapshot = cupboardUid == null
        ? await getDb().child(path).get()
        : await getDb().child("cupboards/$cupboardUid").child(path).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      categories = response.map((key, value) =>
          new MapEntry(key, Category.fromMap(key, cupboardUid, value)));
    }

    return categories;
  }

  @override
  Future<Category> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> remove(Category entity) async {
    DatabaseReference db = getDb()
        .child("cupboards/${entity.cupboardUid}")
        .child("$path/${entity.id}");
    await db.remove();
  }

  @override
  Future<void> update(Category entity) async {
    DatabaseReference db = getDb()
        .child("cupboards/${entity.cupboardUid}")
        .child("$path/${entity.id}");
    await db.set(entity.toMap());
  }

  @override
  String get path => "categories";

  @override
  Future<void> populate(String parentUid) async {
    DataSnapshot snapshot = await getDb().child(path).get();
    final DatabaseReference db = getDb().child("cupboards/$parentUid");

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      db.child(path).set(response);
    }
  }
}
