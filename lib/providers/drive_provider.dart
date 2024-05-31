import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/api/firebase_drive_api.dart';
import 'package:my_app/models/donation.dart';
import 'package:my_app/models/donation_drive.dart';

class DriveProvider with ChangeNotifier {
  late FirebaseDriveAPI driveService;
  late Stream<QuerySnapshot> _driveStream;

  DonationDrive? driveObj;

  DriveProvider() {
    driveService = FirebaseDriveAPI();
    fetchDrives();
  }

  Stream<QuerySnapshot> get drives => _driveStream;
  void fetchDrives(){
    _driveStream = driveService.getAllDrives();
    notifyListeners();
  }

  void addDrive(String name, String desc, List<dynamic> donations) async {
    String message = await driveService.addDrive(name, desc, donations);
    print(message);
    notifyListeners();
  }

  void addDono(String id, String driveId) async {
    String message = await driveService.addDonation(id, driveId);
    print(message);
    notifyListeners();
  }
}