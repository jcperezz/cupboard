import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';

class Category extends Entity {
  Category({
    id,
    owner,
    required this.name,
    this.cupboardUid,
  }) : super(id: id, owner: owner);

  String name;
  String? cupboardUid;

  String toJson() => json.encode(toMap());

  factory Category.fromMap(
          String id, String? cupboardUid, Map<dynamic, dynamic> json) =>
      Category(
        id: id,
        name: json["name"],
        cupboardUid: cupboardUid,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };

  @override
  String toString() => name;
}
