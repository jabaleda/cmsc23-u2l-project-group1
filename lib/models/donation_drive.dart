import 'dart:convert';
// import 'dart:ffi';

import 'package:my_app/models/donation.dart';

class DonationDrive {
  String? name;
  String? desc;
  String? org;
  List<dynamic>? donations;

  DonationDrive({
    this.name,
    this.desc,
    this.org,
    this.donations,
  });

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      name: json['name'],
      desc: json['desc'],
      org: json['org'],
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
      'org': drive.org,
      'donations': drive.donations,
    };
  }
}