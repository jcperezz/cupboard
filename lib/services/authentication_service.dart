import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/providers/firebase_provider.dart';
import 'package:cupboard/services/notifications_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  bool isLoading = false;
  bool userIsAuth = false;

  AuthService() {
    isAuth();
  }

  Future<void> signIn(BuildContext context, String email, String secret) async {
    Labels label = Labels.of(context);
    isLoading = true;
    notifyListeners();
    try {
      print("autenticando usuario");

      UserCredential userCredential = await FirebaseProvider()
          .auth
          .signInWithEmailAndPassword(email: email, password: secret);

      User? user = FirebaseProvider().auth.currentUser;

      if (user != null) {
        NotificationsService.showSnackbar("Usuario autenticado");
      }

      print("usuario autenticado");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
        NotificationsService.showSnackbarError(
            label.getMessage("no_user_found"));
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
        NotificationsService.showSnackbarError(
            label.getMessage("wrong_password"));
      } else {
        print("error ${e.message}");
        NotificationsService.showSnackbarError("${e.message}");
      }
    } catch (e) {
      print(e);
      NotificationsService.showSnackbarError("${e.toString()}");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword(
      BuildContext context, String email, String secret) async {
    isLoading = true;
    notifyListeners();

    Labels label = Labels.of(context);
    print("inicio usuario registrado");
    try {
      UserCredential userCredential = await FirebaseProvider()
          .auth
          .createUserWithEmailAndPassword(email: email, password: secret);

      NotificationsService.showSnackbar(label.getMessage("signup_user"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        NotificationsService.showSnackbarError(
            label.getMessage("weak_password"));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        NotificationsService.showSnackbarError(
            label.getMessage("email_already_exists"));
      } else if (e.code == 'operation-not-allowed') {
        print('authentication method not allowed');
        NotificationsService.showSnackbarError(
            label.getMessage("auth_method_not_allowed"));
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }

    print("fin usuario registrado");
    isLoading = false;
    notifyListeners();
  }

  Future isAuth() async {
    isLoading = true;
    userIsAuth = false;
    notifyListeners();
    FirebaseProvider().auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        userIsAuth = false;
        isLoading = false;
        notifyListeners();
      } else {
        print('User is signed in!');
        userIsAuth = true;
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
