import 'package:cupboard/domain/repositories/abstract_fire_repository.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:cupboard/domain/entities/user_data.dart';
import 'package:cupboard/domain/exceptions/persitence_exception.dart';

class FireUserDataRepository extends AbstractFireRepository<UserData> {
  @override
  Future<String> add(UserData entity) async {
    DatabaseReference db = getDb(entity.uid);
    await db.set(entity.toMap());
    return db.key;
  }

  @override
  Future<Map<String, UserData>> getAll([String? userUid]) async {
    Map<String, UserData> list = Map();
    DataSnapshot snapshot = await getDb().get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;

      list = response
          .map((key, value) => new MapEntry(key, UserData.fromMap(value)));
    }

    return list;
  }

  @override
  Future<UserData> getById(String id) async {
    DataSnapshot snapshot = await getDb(id).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = Map<String, dynamic>.from(snapshot.value);
      UserData user = UserData.fromMap(response);
      return user;
    }

    throw PersistenceException("no_user_found");
  }

  @override
  String get path => "users";

  @override
  Future<void> populate(String uid) {
    // TODO: implement populate
    throw UnimplementedError();
  }

  @override
  Future<void> remove(UserData entity) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> update(UserData entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
