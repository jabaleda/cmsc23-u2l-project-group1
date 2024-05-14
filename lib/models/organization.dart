
import 'dart:convert';

class Organization {//for organization details
  String? name;
  String? id;
  String? about;
  bool statusDonation;
  bool statusApproved;

  Organization({
    required this.name,
    this.id,
    required this.about,
    required this.statusDonation,
    required this.statusApproved

  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json['email'],
      id: json['id'],
      about: json['fname'],
      statusDonation: json['statusDonation'],
      statusApproved: json['statusApproved'],
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
      'statusApproved': org.statusApproved
    };
  }
}
