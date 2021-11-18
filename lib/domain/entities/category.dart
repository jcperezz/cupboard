import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';

class Category extends Entity {
  Category({
    id,
    owner,
    required this.icon,
    required this.name,
  }) : super(id: id, owner: owner);

  String icon;
  String name;

  String toJson() => json.encode(toMap());

  factory Category.fromMap(String id, Map<dynamic, dynamic> json) => Category(
        id: id,
        icon: json["icon"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "icon": icon,
        "name": name,
      };
}
