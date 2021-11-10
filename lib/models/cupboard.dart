import 'dart:convert';

class Cupboard {
  Cupboard({
    required this.count,
    required this.image,
    required this.name,
    this.stages,
    this.id,
  });

  String? id;
  String count;
  String image;
  String name;
  List<dynamic>? stages;

  factory Cupboard.fromJson(String str) => Cupboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cupboard.fromMap(Map<String, dynamic> json, {String? id}) => Cupboard(
        count: json["count"],
        image: json["image"],
        name: json["name"],
        stages: json["stages"] != null ? json["stages"] : null,
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "image": image,
        "name": name,
        "stages":
            stages != null ? stages!.map((e) => e.toMap()).toList() : null,
      };
}

class Stage {
  Stage({
    required this.statusEnum,
    required this.total,
  });

  String statusEnum;
  int total;

  factory Stage.fromJson(String str) => Stage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stage.fromMap(Map<String, dynamic> json) => Stage(
        statusEnum: json["StatusEnum"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "StatusEnum": statusEnum,
        "total": total,
      };
}
