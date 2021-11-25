import 'package:cupboard/data/services/fire_database_service.dart';
import 'package:cupboard/domain/entities/entity.dart';
import 'package:cupboard/domain/repositories/abstract_repository.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class AbstractFireRepository<T extends Entity>
    extends AbstractRepository<T> {
  String get path;

  DatabaseReference getCurrentUserPath([String? uid]) => getDb(uid).child(path);

  DatabaseReference getDb([String? uid]) =>
      FireDatabaseService().databaseByUser(uid);
}
