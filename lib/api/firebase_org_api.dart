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


  Future<String> addOrg(String email, String name, String username, List<String> address, String contactNo, String about, String proof) async { //adding an org
    try {
      Organization org = Organization(//making object for db
              type: 'org',
              email: email,
              name: name,
              about: about,
              username: username,
              address: address,
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

}
