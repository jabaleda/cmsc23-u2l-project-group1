import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthAPI {

  static final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password, BuildContext context) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
      email: email, password: password);

      print(credential);
      return(credential.toString());

      } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return('No user found for that email.');
      } 
      else if (e.code == 'wrong-password') {
        return('Wrong password provided for that user.');
      }
      else{
        return("Error");
      }
    }
  }

  Future<void> signUp(String email, String password) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
      );

      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } 
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

}

