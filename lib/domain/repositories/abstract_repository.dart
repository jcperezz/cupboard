import 'package:cupboard/domain/entities/entity.dart';

///
abstract class AbstractRepository<T extends Entity> {
  Future<Map<String, T>> getAll([String? parentUid]);
  Future<T?> getById(String id);
  Future<String> add(T entity);
  Future<void> update(T entity);
  Future<void> remove(T entity);
  Future<void> populate(String parentUid);
}
