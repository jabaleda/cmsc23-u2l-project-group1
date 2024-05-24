/*
  Donor Provider 
  - Admin Purposes
*/


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donor.dart';
import '../api/firebase_donor_api.dart';

class DonorProvider with ChangeNotifier {
  // api
  late FirebaseDonorAPI donorService;
  // stream
  late Stream<QuerySnapshot> _donorStream;
  Donor? donorObj;

  DonorProvider() {
    // fetch donors
    donorService = FirebaseDonorAPI();
    fetchDonors();
  }

  Stream<QuerySnapshot> get donors => _donorStream;
  // stream getter

  void fetchDonors() {
    // stream
    _donorStream = donorService.getAllDonors();
    notifyListeners();
  }

  void addDonor(String email, String name, String username, String address, String contactNo) async {
    // add to db
    String message = await donorService.addDonor(email, name, username, address, contactNo);
    print(message);
    notifyListeners();
  }

}