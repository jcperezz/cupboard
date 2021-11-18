abstract class Entity {
  final String? id;
  String? owner;

  Entity({this.id, this.owner});

  String toJson();
  Map<String, dynamic> toMap();
}
