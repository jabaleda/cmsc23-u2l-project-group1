/*
  * Commit: 
    Changes:
    - changed declaration of required fields to be non-nullable
    - String address -> List<String> address
    - 
*/


import 'dart:convert';

class Organization {//for organization details
  String name;
  String? id;
  String type;
  String about;
  bool statusDonation;
  bool statusApproved;
  String username;
  String email;
  List<String> address;
  String contactNo;
  String proof;

  Organization({
    required this.name,
    this.id,
    required this.type,
    required this.about,
    required this.statusDonation,
    required this.statusApproved,
    required this.username,
    required this.email,
    required this.address,
    required this.contactNo,
    required this.proof

  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json['name'],
      id: json['id'],
      about: json['about'],
      statusDonation: json['statusDonation'],
      statusApproved: json['statusApproved'],
      type: json['type'],
      username: json['username'],
      email: json['email'],
      address: List.from(json['address']),
      contactNo: json['contactNo'],
      proof: json['proof']
    );
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Organization>((dynamic d) => Organization.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Organization org) {
    return {
      'name': org.name,
      'about': org.about,
      'statusDonation': org.statusDonation,
      'statusApproved': org.statusApproved,
      'type': org.type,
      'username': org.username,
      'email': org.email,
      'address': org.address,
      'contactNo': org.contactNo,
      'proof': org.proof
    };
  }
}
