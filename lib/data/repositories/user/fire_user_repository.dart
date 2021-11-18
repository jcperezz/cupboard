import 'package:firebase_database/firebase_database.dart';

import 'package:cupboard/domain/entities/user_data.dart';
import 'package:cupboard/domain/exeptions/persitence_exception.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';

class FireUserRepository extends AbstractRepository<UserData> {
  @override
  Future<void> add(UserData entity) async {
    return await getRoot(entity.owner).push().set(entity.toMap());
  }

  @override
  Future<Map<String, UserData>> getAll([String? uid]) async {
    Map<String, UserData> list = Map();

    DataSnapshot snapshot = await getRoot(uid).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;

      list = response
          .map((key, value) => new MapEntry(key, UserData.fromMap(value)));
    }

    return list;
  }

  @override
  Future<UserData> getById(String id) async {
    DataSnapshot snapshot = await getRoot(id).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      return UserData.fromMap(response);
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
