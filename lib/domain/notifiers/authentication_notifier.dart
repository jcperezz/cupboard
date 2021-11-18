import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cupboard/data/services/authentication_service.dart';
import 'package:cupboard/data/services/fire_auth_service.dart';

import 'package:cupboard/domain/exeptions/auth_exception.dart';
import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/services/notifications_service.dart';

class AuthenticationNotifier extends ChangeNotifier {
  bool isLoading = false;
  String? uid;

  AuthenticationNotifier() {
    isAuth();
  }

  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String secret) async {
    Labels labels = Labels.of(context);
    isLoading = true;
    notifyListeners();

    try {
      await AuthenticationService().signInWithEmailAndPassword(email, secret);
    } on AuthException catch (e) {
      print("Auth error $e");
      NotificationsService.showSnackbarError(labels.getMessage(e.label));
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
      await AuthenticationService()
          .createUserWithEmailAndPassword(email, secret);
    } on AuthException catch (e) {
      print("Auth error $e");
      NotificationsService.showSnackbarError(label.getMessage(e.label));
    } catch (e) {
      print(e);
      NotificationsService.showSnackbarError("${e.toString()}");
    }

    print("fin usuario registrado");
    isLoading = false;
    notifyListeners();
  }

  Future isAuth() async {
    isLoading = true;
    uid = null;
    notifyListeners();

    FireAuthService.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        uid = null;
        isLoading = false;
        notifyListeners();
      } else {
        print('User is signed in!');
        uid = user.uid;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
