/*
  Donor Model
*/

import 'dart:convert';

class Donor {
  String name;
  String username;
  String email;
  List<String> address;
  String contactNo;
  String type;
  String? id;

  Donor({
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.contactNo,
    required this.type,
    this.id
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: List.from(json['address']),
      contactNo: json['contactNo'],
      type: json['type'],
      id: json['id']
    );
  }

  static List<Donor> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donor>((dynamic d) => Donor.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donor donor) {
    return {
      'name': donor.name,
      'username': donor.username,
      'email': donor.email,
      'address': donor.address,
      'contactNo': donor.contactNo,
      'type': donor.type,
      'id': donor.id
    };
  }
}

