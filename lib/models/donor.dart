/*
  Donor Model
*/

import 'dart:convert';

class Donor {
  String? name;
  String? username;
  String? email;
  String? password;
  String? address;
  String? contactNo;

  Donor({
    this.name,
    this.username,
    this.email,
    this.password,
    this.address,
    this.contactNo
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      contactNo: json['contactNo']
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
      'password': donor.password,
      'address': donor.address,
      'contactNo': donor.contactNo
    };
  }
}

