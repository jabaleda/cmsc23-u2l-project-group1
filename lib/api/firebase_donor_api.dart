import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donor.dart';


class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonors() { //get all donors
    return db.collection("donors").snapshots();
  }


  Stream<QuerySnapshot> getThisDonor(String email){
    return db.collection("donors").where("email", isEqualTo: email).snapshots();
  }

  Future<String> addDonor(String email, String name, String username, List<String> address, String contactNo) async { //adding a donor
    try {
      Donor donor = Donor(//making object for db
              type: 'donor',
              email: email,
              name: name,
              username: username,
              address: address,
              contactNo: contactNo
              );
      final newdonor = donor.toJson(donor);

      await db.collection("donors").add(newdonor);
      return "Successfully added!";

    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

}
