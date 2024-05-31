import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // Non specific yet. Needs Donor id to filter
  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  // get donations specific to user
  Stream<QuerySnapshot> getTheseDonations(String email) {
    print('received: $email');
    return db.collection("donations").where("donor", isEqualTo: email).snapshots();
  }

  // add a donation
  Future<String> addDonation(Map<String, dynamic> donation) async {
    try {
      await db.collection("donations").add(donation);
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // cancel a donation 
  Future<String> editDonStat(String id, String status) async {
    try {
      await db.collection("donations").doc(id)
        .update({"status": status});
        return "Successfully cancelled!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  


}
