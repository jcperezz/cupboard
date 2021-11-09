import 'dart:convert';

class Cupboard {
  Cupboard({
    required this.count,
    required this.image,
    required this.name,
    this.id,
  });

  String? id;
  String count;
  String image;
  String name;

  factory Cupboard.fromJson(String str) => Cupboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cupboard.fromMap(Map<String, dynamic> json) => Cupboard(
        count: json["count"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "image": image,
        "name": name,
      };
}
