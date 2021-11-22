import 'package:firebase_database/firebase_database.dart';

import 'package:cupboard/data/repositories/user/fire_user_repository.dart';

import 'package:cupboard/data/services/shared_preferences_service.dart';

import 'package:cupboard/domain/entities/cupboard.dart';
import 'package:cupboard/domain/entities/user_data.dart';

import 'package:cupboard/domain/repositories/abstract_repository.dart';

class FireCupboardRepository extends AbstractRepository<Cupboard> {
  @override
  Future<void> add(Cupboard entity) async {
    String? uid =
        await SharedPreferencesService.instance.getString("current-uid-user");

    DatabaseReference db = getCurrentUserPath().push();
    await db.set(entity.toMap());
    String keyNewCupboard = db.key;

    await getCurrentUserPath(uid)
        .push()
        .set(UserCupboard(key: keyNewCupboard, name: entity.name).toMap());
  }

  @override
  Future<Map<String, Cupboard>> getAll() async {
    String? uid =
        await SharedPreferencesService.instance.getString("current-uid-user");

    Map<String, Cupboard> list = Map();

    if (uid == null) return list;

    UserData user = await FireUserRepository().getById(uid);

    if (user.cupboards != null) {
      for (var userCupboard in user.cupboards!) {
        Cupboard? c = await getById(userCupboard.key);

        print("cupboard ${userCupboard.key} $c");

        if (c != null) list[userCupboard.key] = c;
      }
    }

    return list;
  }

  @override
  Future<Cupboard?> getById(String id) async {
    DataSnapshot snapshot = await getCurrentUserPath().child(id).get();

    if (snapshot.value != null) {
      Map<String, dynamic> response = snapshot.value;
      return Cupboard.fromMap(response, id: id);
    }

    return null;
  }

  @override
  String get path => "cupboards";

  @override
  Future<void> populate(String uid) {
    // TODO: implement populate
    throw UnimplementedError();
  }

  @override
  Future<void> remove(Cupboard entity) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> update(Cupboard entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
