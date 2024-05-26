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
  Organization? orgObj;

  OrgProvider() {
    // fetch donors
    orgService = FirebaseOrgAPI();
    fetchOrgs();
  }

  Stream<QuerySnapshot> get orgs => _orgStream;
  // stream getter

  void fetchOrgs() {
    // stream
    _orgStream = orgService.getAllOrgs();
    notifyListeners();
  }

  void addOrg(String email, String name, String username, String address, String contactNo, String about, String proof) async {
    // add to db
    String message = await orgService.addOrg(email, name, username, address, contactNo, about, proof);
    print(message);
    notifyListeners();
  }

}