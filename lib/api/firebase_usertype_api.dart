/*
 * NEW: API for new collection: genUsers collection 
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/general_user.dart';

class FirebaseUsertypeAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // * returns user type base on user email
  Future<String> getThisUser(String email) async {
    try {
      print("getting this user reached.");
      dynamic type = await db.collection("genUsers").where("email", isEqualTo: email).get().then((QuerySnapshot querysnap) {
        var doc = querysnap.docs[0].data();
        GeneralUser user = GeneralUser.fromJson(doc as Map<String, dynamic>);
        return user.type;
      });
      return type;
      // return type;
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // * adds new document to genUser collection on sign up
  Future<String> addUser(String email, String type) async {
    try {
      GeneralUser genUser = GeneralUser(
        email: email,
        type: type
      );

      final newUser = genUser.toJson(genUser);

      await db.collection("genUsers").add(newUser);
      return 'Successfully added!';

    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

}