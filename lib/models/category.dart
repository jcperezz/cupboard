import 'dart:convert';

class Category {
  Category({
    required this.id,
    required this.icon,
    required this.name,
  });

  String id;
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
