import 'dart:convert';

import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/entities/entity.dart';

class Cupboard extends Entity {
  Cupboard({
    required this.count,
    required this.image,
    required this.name,
    this.categories,
    id,
    owner,
  }) : super(id: id, owner: owner);

  int count;
  String image;
  String name;
  List<Category>? categories;

  factory Cupboard.fromJson(String str) => Cupboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cupboard.fromMap(Map<String, dynamic> json, {String? id}) => Cupboard(
        count: json["count"] ?? 0,
        image: json["image"],
        name: json["name"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "image": image,
        "name": name,
      };
}
