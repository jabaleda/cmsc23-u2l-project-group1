import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/organization.dart';


class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllOrgs() { //get all orgs
    return db.collection("organizations").snapshots();
  }

  Stream<QuerySnapshot> getApprovedOrgs() {
    return db.collection("organizations").where("statusApproved", isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot> getOpenOrgs() {
    return db.collection("organizations").where("statusDonation", isEqualTo: true).snapshots();
  }

  Future<String> getOrgStatus(String email) async {
    try {
      print("getting this org reached.");
      dynamic type = await db.collection("organizations").where("email", isEqualTo: email).get().then((QuerySnapshot querysnap) {
        var doc = querysnap.docs[0].data();
        Organization org = Organization.fromJson(doc as Map<String, dynamic>);
        return org.statusApproved.toString();
      });
      return type;
      // return type;
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }


  Future<String> addOrg(String email, String name, String username, 
                        // String address, 
                        String contactNo, String about, String proof) async { //adding an org
    try {
      Organization org = Organization(//making object for db
              type: 'org',
              email: email,
              name: name,
              about: about,
              username: username,
              // address: address,
              contactNo: contactNo,
              statusApproved: false,
              statusDonation: false,
              proof: proof
              );
      final neworg = org.toJson(org);

      await db.collection("organizations").add(neworg);
      return "Successfully added!";

    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> findOrg(String email) {
    return db.collection("organizations").where("email", isEqualTo: email).snapshots();
  }

  Future<String> toggleStatus(String id, bool status) async {
    try {
      await db.collection("organizations").doc(id).update({"statusApproved": status});

      return "Successfully toggled!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

}
