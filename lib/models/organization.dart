
import 'dart:convert';

class Organization {//for organization details
  final int orgId;
  String? name;
  String? id;
  String? about;
  bool status;

  Organization({
    required this.orgId,
    required this.name,
    this.id,
    required this.about,
    required this.status,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      orgId: json['userId'],
      name: json['email'],
      id: json['id'],
      about: json['fname'],
      status: json['lname'],
    );
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Organization>((dynamic d) => Organization.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Organization org) {
    return {
      'orgId': org.orgId,
      'name': org.name,
      'about': org.about,
      'status': org.status,
    };
  }
}
