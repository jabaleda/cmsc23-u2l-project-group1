/*
  Org Provider
  - Admin Purposes
*/


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/organization.dart';
import '../api/firebase_org_api.dart';

class OrgProvider with ChangeNotifier {
  // api
  late FirebaseOrgAPI orgService;
  // stream
  late Stream<QuerySnapshot> _orgStream;
  late Stream<QuerySnapshot> _approvedStream;
  late Stream<QuerySnapshot> _openStream;

  Organization? orgObj;

  OrgProvider() {
    // fetch orgs
    orgService = FirebaseOrgAPI();
    fetchOrgs();
    fetchApprovedOrgs();
    fetchOpenOrgs();
  }

  Stream<QuerySnapshot> get orgs => _orgStream;
  Stream<QuerySnapshot> get approvedOrgs => _approvedStream;
  Stream<QuerySnapshot> get openOrgs => _openStream;
  // stream getter


  // * Admin Purposes
  void fetchOrgs() {
    // stream
    _orgStream = orgService.getAllOrgs();
    notifyListeners();
  }

  // Formerly interpreted to be for Donor purposes
  void fetchApprovedOrgs() {
    _approvedStream = orgService.getApprovedOrgs();
  }

  // * Donor Purposes
  void fetchOpenOrgs() {
    _openStream = orgService.getOpenOrgs();
  }



  void addOrg(String email, String name, String username, 
              // String address, 
              String contactNo, String about, String proof) async {
    // add to db
    String message = await orgService.addOrg(email, name, username, 
                                            // address, 
                                            contactNo, about, proof);
    print(message);
    notifyListeners();
  }

  void toggleStatus(String id, bool status) async {
    await orgService.toggleStatus(id, status);
    notifyListeners();
  }

}