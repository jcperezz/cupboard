import 'package:firebase_auth/firebase_auth.dart';

import 'package:cupboard/data/repositories/user/fire_user_repository.dart';

import 'package:cupboard/data/services/fire_auth_service.dart';

import 'package:cupboard/domain/entities/user_data.dart';

import 'package:cupboard/domain/exceptions/auth_exception.dart';
import 'package:cupboard/domain/exceptions/persitence_exception.dart';

class AuthenticationService {
  FireUserRepository repository = FireUserRepository();

  Future<void> signInWithEmailAndPassword(String email, String secret) async {
    try {
      print("autenticando usuario");
      FirebaseAuth auth = FireAuthService.auth;

      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: secret);

      User? user = userCredential.user;

      if (user != null) {
        UserData userData = await repository.getById(user.uid);
        print("usuario autenticado");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
        throw AuthException("no_user_found");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
        throw AuthException("wrong_password");
      } else {
        print("error ${e.message}");
        throw AuthException("unknown_error", e.message);
      }
    } on PersistenceException catch (e) {
      print("No user found in database");
      throw AuthException(e.label);
    } catch (e) {
      print(e);
      throw AuthException("unknown_error", e.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String secret) async {
    print("inicio usuario registrado");

    FirebaseAuth auth = FireAuthService.auth;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: secret);

      User? user = userCredential.user;

      if (user != null) {
        UserData entity = UserData(uid: user.uid);
        entity.email = email;

        await repository.add(entity);
        print("usuario creado");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw AuthException("weak_password");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        throw AuthException("email_already_exists");
      } else if (e.code == 'operation-not-allowed') {
        print('authentication method not allowed');
        throw AuthException("auth_method_not_allowed");
      } else {
        print(e);
        throw AuthException("unknown_error", e.message);
      }
    } catch (e) {
      print(e);
      throw AuthException("unknown_error", e.toString());
    }
  }
}
