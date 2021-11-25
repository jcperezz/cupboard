import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';

enum MeasureType {
  units,
  gram,
  pound,
  kilogram,
}

MeasureType toMeasureType(dynamic value) {
  return MeasureType.values.firstWhere((e) => e.toString() == value);
}

class Product extends Entity {
  Product({
    String? id,
    required this.category,
    required this.name,
    required this.measureType,
    this.image,
    this.cupboardUid,
  }) : super(id: id);

  String name;
  String category;
  String? image;
  String? cupboardUid;
  MeasureType measureType;

  String toJson() => json.encode(toMap());

  factory Product.fromMap(String id, Map<String, dynamic> json) => Product(
        measureType: toMeasureType(json["measureType"]),
        category: json["category"],
        name: json["name"],
        image: json["image"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "name": name,
        "image": image,
        "measureType": measureType.toString(),
      };
}
