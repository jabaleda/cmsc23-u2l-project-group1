import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/donation.dart';
import 'package:my_app/models/donation_drive.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDrives() { 
    return db.collection("donationDrives").snapshots();
  }

  Future<String> addDrive(String name, String desc, List<dynamic> donations) async { 
    try {
      DonationDrive drive = DonationDrive(//making object for db
              name: name,
              desc: desc,
              donations: donations,
              );
      final newDrive = drive.toJson(drive);

      await db.collection("donationDrives").add(newDrive);
      return "Successfully added!";

    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> addDonation(String id, String driveId) async {
    try {
      await db.collection("donationDrives").doc(driveId).update({
        "donations": FieldValue.arrayUnion([id])
      });
      return "Added to org donations";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

}
