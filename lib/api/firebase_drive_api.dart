import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/donation.dart';
import 'package:my_app/models/donation_drive.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDrives() { //get all orgs
    return db.collection("donationDrives").snapshots();
  }

  Future<String> addDrive(String name, String desc, List<Donation> donations) async { //adding an org
    try {
      DonationDrive org = DonationDrive(//making object for db
              name: name,
              desc: desc,
              donations: donations,
              );
      final neworg = org.toJson(org);

      await db.collection("organizations").add(neworg);
      return "Successfully added!";

    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

}
