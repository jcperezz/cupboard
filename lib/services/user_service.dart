import 'package:cupboard/providers/local_storage_provider.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class UserService extends ChangeNotifier {
  String? token;
  AuthStatus authStatus = AuthStatus.checking;

  UserService() {
    this.isAuthenticated();
  }

  login(String email, String password) {
    SharedPreferencesProvider.prefs.setString("token", "my-token-123456");
  }

  Future<bool> isAuthenticated() async {
    final token = SharedPreferencesProvider.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    authStatus = AuthStatus.authenticated;

    notifyListeners();
    return true;
  }
}
