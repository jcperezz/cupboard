import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';

class UserData extends Entity {
  UserData({
    this.cupboards,
    this.email,
    required this.uid,
  }) : super(id: uid);

  List<UserCupboard>? cupboards;
  String? email;
  String uid;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) {
    List<UserCupboard> list = [];

    if (json["cupboards"] != null) {
      Map<String, dynamic> result =
          Map<String, dynamic>.from(json["cupboards"]);

      result.forEach((key, value) {
        list.add(
            UserCupboard.fromMap(Map<String, dynamic>.from(value), id: key));
      });
    }

    return UserData(
      cupboards: json["cupboards"] != null ? list : null,
      email: json["email"],
      uid: json["uid"],
    );
  }

  Map<String, dynamic> toMap() => {
        "cupboards":
            cupboards != null ? cupboards!.map((e) => e.toMap()) : null,
        "email": email,
        "uid": uid,
      };
}

class UserCupboard extends Entity {
  UserCupboard({
    String? id,
    String? owner,
    required this.key,
    required this.name,
  }) : super(id: id, owner: owner);

  String key;
  String name;

  factory UserCupboard.fromJson(String str) =>
      UserCupboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCupboard.fromMap(Map<String, dynamic> json, {String? id}) =>
      UserCupboard(
        key: json["key"],
        name: json["name"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "name": name,
      };
}
