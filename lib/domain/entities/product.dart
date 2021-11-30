import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';

class Product extends Entity {
  Product({
    String? id,
    this.category,
    required this.name,
    this.image,
    String? owner,
    this.cupboardUid,
  }) : super(id: id, owner: owner);

  String name;
  String? category;
  String? image;
  String? cupboardUid;

  String toJson() => json.encode(toMap());

  factory Product.fromMap(String id, Map<String, dynamic> json) => Product(
        category: json["category"],
        name: json["name"],
        image: json["image"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "name": name,
        "image": image,
      };

  @override
  String toString() => name;
}
