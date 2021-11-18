import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';

class UserData extends Entity {
  UserData({
    this.cupboardsId,
    this.email,
    required this.uid,
  }) : super(id: uid);

  CupboardsId? cupboardsId;
  String? email;
  String uid;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        cupboardsId: CupboardsId.fromMap(json["cupboards"]),
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "cupboards": cupboardsId != null ? cupboardsId!.toMap() : null,
        "email": email,
        "uid": uid,
      };
}

class CupboardsId {
  CupboardsId({
    required this.id,
    required this.cupboards,
  });

  String id;
  List<String> cupboards;

  factory CupboardsId.fromJson(String str) =>
      CupboardsId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CupboardsId.fromMap(Map<String, dynamic> json) {
    final String id = json.keys.first;
    final cupboards = List<String>.from(json[id].map((x) => x));

    return CupboardsId(id: id, cupboards: cupboards);
  }

  Map<String, dynamic> toMap() => {
        id: List<dynamic>.from(cupboards.map((x) => x)),
      };
}
