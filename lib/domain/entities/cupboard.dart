import 'dart:convert';

import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/entities/entity.dart';
import 'package:cupboard/domain/entities/product_item.dart';

class Cupboard extends Entity {
  Cupboard({
    required this.image,
    required this.name,
    this.inventory,
    this.totalItems = 0,
    this.totalCloseToExpire = 0,
    this.totalExpired = 0,
    this.categories,
    id,
    owner,
  }) : super(id: id, owner: owner);

  String image;
  String name;
  List<Category>? categories;
  Map<String, ProductItem>? inventory;
  int totalItems;
  int totalCloseToExpire;
  int totalExpired;

  factory Cupboard.fromJson(String str) => Cupboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cupboard.fromMap(Map<String, dynamic> json, {String? id}) {
    final Map<String, ProductItem>? inventory = json["inventory"] != null
        ? json["inventory"].map<String, ProductItem>((key, value) =>
            MapEntry<String, ProductItem>(
                key, ProductItem.fromMap(value, id: key)))
        : null;

    int totalItems = 0;
    int totalCloseToExpire = 0;
    int totalExpired = 0;

    if (inventory != null) {
      inventory.forEach((key, value) {
        totalItems++;

        switch (value.productStatus) {
          case InventoryStatus.close_to_expire:
            totalCloseToExpire++;
            break;
          case InventoryStatus.expired:
            totalExpired++;
            break;
          default:
        }
      });
    }

    return Cupboard(
      inventory: inventory,
      totalItems: totalItems,
      totalCloseToExpire: totalCloseToExpire,
      totalExpired: totalExpired,
      image: json["image"],
      name: json["name"],
      id: id,
    );
  }

  Map<String, dynamic> toMap() => {
        "image": image,
        "name": name,
      };
}
