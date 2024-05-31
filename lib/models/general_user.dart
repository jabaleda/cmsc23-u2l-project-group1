/*
 * NEW: Model for new collection: genUsers collection 
 */

import 'dart:convert';

class GeneralUser {
  String email;
  String type;

  GeneralUser({
    required this.email,
    required this.type
  });


  factory GeneralUser.fromJson(Map<String, dynamic> json){
    return GeneralUser(email: json['email'], type: json['type']);
  }

  static List<GeneralUser> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<GeneralUser>((dynamic d) => GeneralUser.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(GeneralUser genUser) {
    return {
      'email' : genUser.email,
      'type' : genUser.type
    };
  }



}