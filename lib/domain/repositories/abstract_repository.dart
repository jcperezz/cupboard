import 'package:cupboard/data/services/fire_database_service.dart';
import 'package:cupboard/domain/entities/entity.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class AbstractRepository<T extends Entity> {
  Future<Map<String, T>> getAll([String? uid]);
  Future<T> getById(String id);
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> remove(T entity);

  String get path;

  Future<void> populate(String uid);

  DatabaseReference getRoot([String? uid]) {
    return FireDatabaseService().databaseByUser(uid).child(path);
  }
}
