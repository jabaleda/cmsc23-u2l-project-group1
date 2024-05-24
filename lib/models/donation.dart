/*
  Donation Model
*/

import 'dart:convert';

class Donation {
  String? id;
  String org;
  String donor;      // identifier. username?
  String category;
  bool pickUp;
  String weight;     // type=number in db
  String unit;
  String date;       //
  String status;

  // for pick up == true
  String? address;
  String? contactNo;

  // for pick up == false => drop-off
  // QR code

  Donation({
    this.id,
    required this.org,
    required this.donor,
    required this.category,
    required this.pickUp,
    required this.weight,
    required this.unit,
    required this.date,
    required this.status,
    this.address,
    this.contactNo
    // How to store QR code?
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      org: json['org'],
      donor: json['donor'],
      category: json['category'],
      pickUp: json['pickUp'],
      weight: json['weight'],
      unit: json['unit'],
      date: json['date'],
      status: json['status'],
      address: json['address'],
      contactNo: json['contactno']
      // QR code
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'org': donation.org,
      'donor': donation.donor,
      'category': donation.category,
      'pickUp': donation.pickUp,
      'weight': donation.weight,
      'unit': donation.unit,
      'date': donation.date,
      'status': donation.status,
      'address': donation.address,
      'contactNo': donation.contactNo
      // QR code
    };
  }

}
