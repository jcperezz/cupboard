import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  UserData({
    this.email,
    required this.uid,
  });

  factory UserData.fromFirebase(User user) =>
      UserData(email: user.email, uid: user.uid);

  String? email;
  String uid;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "uid": uid,
      };
}
