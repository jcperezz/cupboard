import 'dart:convert';

import 'package:cupboard/domain/entities/entity.dart';
import 'package:intl/intl.dart';

enum InventoryStatus {
  pending,
  avalaible,
  close_to_expire,
  expired,
}

class ProductItem extends Entity {
  ProductItem({
    this.category,
    required this.name,
    this.quantity,
    this.expirationDate,
    this.image,
    String? id,
    String? owner,
    this.cupboardUid,
  }) : super(id: id, owner: owner);

  String? category;
  String name;
  int? quantity;
  String? expirationDate;
  String? image;
  String? cupboardUid;

  DateTime? get expirationDateObject =>
      expirationDate != null ? DateFormat.yMd().parse(expirationDate!) : null;

  String? get expirationDateShort => expirationDateObject != null
      ? DateFormat("d/M/yy").format(expirationDateObject!)
      : null;

  InventoryStatus get productStatus {
    if (expirationDateObject == null) {
      return InventoryStatus.pending;
    } else {
      final int days = DateTime.now().difference(expirationDateObject!).inDays;
      if (days <= 5) {
        return InventoryStatus.expired;
      } else if (days <= 30) {
        return InventoryStatus.close_to_expire;
      } else {
        return InventoryStatus.avalaible;
      }
    }
  }

  factory ProductItem.fromJson(String str) =>
      ProductItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductItem.fromMap(Map<String, dynamic> json, {String? id}) =>
      ProductItem(
        category: json["category"],
        name: json["name"],
        quantity: json["quantity"],
        expirationDate: json["expiration_date"],
        image: json["image"],
        cupboardUid: json["cupboardUid"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "name": name,
        "quantity": quantity,
        "expiration_date": expirationDate,
        "image": image,
        "cupboardUid": cupboardUid,
      };
}
