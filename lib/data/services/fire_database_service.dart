import 'package:firebase_database/firebase_database.dart';

class FireDatabaseService {
  FirebaseDatabase _db;

  FireDatabaseService() : _db = FirebaseDatabase.instance;

  DatabaseReference get database => _db.reference();

  DatabaseReference databaseByUser(String? uid) => uid != null
      ? FireDatabaseService().database.child("users/" + uid)
      : database;
}
