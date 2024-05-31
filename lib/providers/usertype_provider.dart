/*
 * NEW: Provider for new collection: genUsers collection 
 */

import 'package:flutter/material.dart';
import 'package:my_app/api/firebase_usertype_api.dart';

class UsertypeProvider with ChangeNotifier {
  // api
  late FirebaseUsertypeAPI typeService;

  UsertypeProvider() {
    // fetch
    typeService = FirebaseUsertypeAPI();
  }

  Future<void> addUser(String email, String type) async {
    String msg = await typeService.addUser(email, type);
    print(msg);
    notifyListeners();
  }

}