import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';

class Product extends Entity {
  Product(
      {required this.category,
      required this.name,
      this.quantity,
      this.expirationDate,
      this.image,
      String? id,
      String? owner})
      : super(id: id, owner: owner);

  String category;
  String name;
  int? quantity;
  String? expirationDate;
  String? image;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json, {String? id}) => Product(
        category: json["category"],
        name: json["name"],
        quantity: json["quantity"],
        expirationDate: json["expiration_date"],
        image: json["image"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "name": name,
        "quantity": quantity,
        "expiration_date": expirationDate,
        "image": image,
      };
}
