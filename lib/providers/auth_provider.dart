import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';


class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _uStream;
  User? userObj;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;

  User? get user => authService.getUser();

  void fetchAuthentication() {
    _uStream = authService.getSignedIn();
    notifyListeners();
  }

  Future<bool> getType(String? email) async {
    return authService.getEmailOrg(email!);
  }

  Future<void> signUp(String email, String password) async {
    await authService.signUp(email, password); 
    notifyListeners();
  }

  Future<void> signIn(String email, String password, BuildContext context) async {
    await authService.signIn(email, password, context);
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}


