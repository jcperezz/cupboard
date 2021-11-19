import 'package:firebase_database/firebase_database.dart';

import 'package:cupboard/domain/entities/user_data.dart';
import 'package:cupboard/domain/exceptions/persitence_exception.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';

class FireUserRepository extends AbstractRepository<UserData> {
  @override
  Future<void> add(UserData entity) async {
    return await getDb(entity.uid).set(entity.toMap());
  }

  @override
  Future<Map<String, UserData>> getAll() async {
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
      Map<String, dynamic> response = snapshot.value;
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
