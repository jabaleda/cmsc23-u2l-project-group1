/*
  Donor Provider 
  - Admin Purposes
*/


import 'package:flutter/material.dart';

import '../models/donor.dart';

class DonorListProvider with ChangeNotifier {
  // api
  // stream


  DonorListProvider() {
    // fetch donors
  }

  // stream getter

  void fetchDonors() {
    // stream
    notifyListeners();
  }

  void addDonor(Donor donor) async {
    // add to db
    notifyListeners();
  }

  // edit user?

  

}