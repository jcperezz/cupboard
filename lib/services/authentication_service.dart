import 'package:cupboard/providers/firebase_provider.dart';
import 'package:cupboard/services/notifications_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  AuthService() {
    isAuth();
  }

  Future<void> signIn(String email, String secret) async {
    try {
      print("autenticando usuario");

      UserCredential userCredential = await FirebaseProvider()
          .auth
          .signInWithEmailAndPassword(email: email, password: secret);

      User? user = FirebaseProvider().auth.currentUser;

      if (user != null) {
        NotificationsService.showSnackbar("Usuario autenticado");
      }

      print("usuario no autenticado");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
        NotificationsService.showSnackbar("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");

        NotificationsService.showSnackbar(
            "Wrong password provided for that user.");
      } else {
        print("error ${e.message}");
        NotificationsService.showSnackbar("${e.message}");
      }
    } catch (e) {
      print(e);
      NotificationsService.showSnackbar("${e.toString()}");
    }
  }

  void createUserWithEmailAndPassword() async {
    print("inicio usuario registrado");
    try {
      UserCredential userCredential = await FirebaseProvider()
          .auth
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");

      print("usuario registrado");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'operation-not-allowed') {
        print('authentication method not allowed');
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }

    print("fin usuario registrado");
  }

  Future isAuth() async {
    FirebaseProvider().auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
