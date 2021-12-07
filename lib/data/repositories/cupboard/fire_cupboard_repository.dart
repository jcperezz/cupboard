import 'package:firebase_database/firebase_database.dart';

import 'package:cupboard/data/repositories/user/fire_user_repository.dart';

import 'package:cupboard/domain/entities/cupboard.dart';
import 'package:cupboard/domain/entities/user_data.dart';

import 'package:cupboard/domain/repositories/abstract_fire_repository.dart';

class FireCupboardRepository extends AbstractFireRepository<Cupboard> {
  final FireUserDataRepository userDataRepository;

  FireCupboardRepository(this.userDataRepository);

  @override
  Future<String> add(Cupboard entity) async {
    DatabaseReference db = getDb().child(path).push();
    await db.set(entity.toMap());
    String keyNewCupboard = db.key;

    await getDb(entity.owner)
        .child("$path/$keyNewCupboard")
        .set(UserCupboard(key: keyNewCupboard, name: entity.name).toMap());

    return keyNewCupboard;
  }

  @override
  Future<Map<String, Cupboard>> getAll([String? userUid]) async {
    Map<String, Cupboard> list = Map();

    if (userUid == null) return list;

    UserData user = await userDataRepository.getById(userUid);

    if (user.cupboards != null) {
      for (var userCupboard in user.cupboards!) {
        Cupboard? c = await getById(userCupboard.key);
        if (c != null) {
          c.owner = userUid;
          list[userCupboard.key] = c;
        }
      }
    }

    return list;
  }

  @override
  Future<Cupboard?> getById(String id) async {
    DataSnapshot snapshot = await getCurrentUserPath().child(id).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = Map<String, dynamic>.from(snapshot.value);
      return Cupboard.fromMap(Map<String, dynamic>.from(response), id: id);
    }

    return null;
  }

  @override
  String get path => "cupboards";

  @override
  Future<void> populate(String uid) {
    throw UnimplementedError();
  }

  @override
  Future<void> remove(Cupboard entity) async {
    DatabaseReference db = getDb().child("$path/${entity.id}");
    await db.remove();

    print("owner ${entity.owner}");

    await getDb(entity.owner).child("$path/${entity.id}").remove();
  }

  @override
  Future<void> update(Cupboard entity) async {
    DatabaseReference db = getDb().child("$path/${entity.id}");
    await db.set(entity.toMap());
  }
}
