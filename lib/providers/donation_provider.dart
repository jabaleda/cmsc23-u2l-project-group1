/*
  Donation Provider
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/api/firebase_donation_api.dart';

import '../models/donation.dart';

class DonorDonationProvider with ChangeNotifier {
  // donation api
  FirebaseDonationAPI firebaseService = FirebaseDonationAPI();
  // stream
  late Stream<QuerySnapshot> _donationStream;

  // late Stream<QuerySnapshot> _uniqueDonorStream;
  
  // ignore: non_constant_identifier_names
  DonorDonationProvider() {
    fetchDonationList();
  }

  // getter
  Stream<QuerySnapshot> get donations => _donationStream;

  void fetchDonationList() {
    // set stream
    _donationStream = firebaseService.getAllDonations();
    notifyListeners();
  }

  void addDonation(Donation donation) async {
    // add by api
    String message = await firebaseService.addDonation(donation.toJson(donation));
    print(message);
    notifyListeners();
  }

  void editDonStat(String id, String status) async {
    // edit status by api
    await firebaseService.editDonStat(id, status);
    notifyListeners();
  }

}