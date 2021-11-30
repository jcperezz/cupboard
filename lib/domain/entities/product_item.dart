import 'dart:convert';

import 'package:cupboard/domain/entities/product.dart';
import 'package:intl/intl.dart';

enum InventoryStatus {
  pending,
  avalaible,
  close_to_expire,
  expired,
}

class ProductItem extends Product {
  static final short_date_formater = DateFormat("d/M/yy");
  static final full_date_formater = DateFormat("dd/MM/yyyy");
  static final db_date_formater = DateFormat.yMd();

  ProductItem({
    String? category,
    required String name,
    this.quantity,
    this.expirationDate,
    String? image,
    String? id,
    String? owner,
    String? cupboardUid,
    this.detail,
  }) : super(
          name: name,
          category: category,
          image: image,
          id: id,
          owner: owner,
          cupboardUid: cupboardUid,
        );

  int? quantity;
  String? expirationDate;
  String? detail;

  DateTime? get expirationDateObject =>
      expirationDate != null ? db_date_formater.parse(expirationDate!) : null;

  String? get expirationDateShort => expirationDateObject != null
      ? short_date_formater.format(expirationDateObject!)
      : null;
  String? get expirationDateFull => expirationDateObject != null
      ? full_date_formater.format(expirationDateObject!)
      : null;

  InventoryStatus get productStatus {
    if (expirationDateObject == null) {
      return InventoryStatus.pending;
    } else {
      final int days = expirationDateObject!.difference(DateTime.now()).inDays;
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

  factory ProductItem.fromProduct(Product p) => ProductItem(
        name: p.name,
        category: p.category,
        cupboardUid: p.cupboardUid,
        image: p.image,
        owner: p.owner,
      );

  String toJson() => json.encode(toMap());

  factory ProductItem.fromMap(Map<String, dynamic> json, {String? id}) =>
      ProductItem(
        category: json["category"],
        name: json["name"],
        quantity: json["quantity"],
        expirationDate: json["expiration_date"],
        image: json["image"],
        cupboardUid: json["cupboardUid"],
        detail: json["detail"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "name": name,
        "quantity": quantity,
        "expiration_date": expirationDate,
        "image": image,
        "cupboardUid": cupboardUid,
        "detail": detail,
      };
}
