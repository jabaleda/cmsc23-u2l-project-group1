import 'dart:convert';
// import 'dart:ffi';

import 'package:my_app/models/donation.dart';

class DonationDrive {
  String? name;
  String? desc;
  List<dynamic>? donations;

  DonationDrive({
    this.name,
    this.desc,
    this.donations,
  });

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      name: json['name'],
      desc: json['desc'],
      donations: json['donations'],
    );
  }

  static List<DonationDrive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<DonationDrive>((dynamic d) => DonationDrive.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(DonationDrive drive) {
    return {
      'name': drive.name,
      'desc': drive.desc,
      'donations': drive.donations,
    };
  }
}