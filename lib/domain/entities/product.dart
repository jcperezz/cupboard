import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';
import 'package:cupboard/domain/entities/product_item.dart';

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

  factory Product.fromMap(
    String id,
    String? cupboardUid,
    Map<String, dynamic> json,
  ) =>
      Product(
        category: json["category"],
        name: json["name"],
        cupboardUid: cupboardUid,
        id: id,
      );

  factory Product.fromItem(ProductItem item) => Product(
        category: item.category,
        name: item.name,
        owner: item.owner,
        cupboardUid: item.cupboardUid,
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "name": name,
      };

  @override
  String toString() => "$name $category $owner $cupboardUid";
}
