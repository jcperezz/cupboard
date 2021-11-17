import 'package:firebase_database/firebase_database.dart';

class FireDbProvider {
  DatabaseReference get database => FirebaseDatabase.instance.reference();

  prueba() {
    database.child('categories').get().then((DataSnapshot? snapshot) {
      print(
          'Connected to directly configured database and read ${snapshot!.value}');
    });
  }
}
