/*
  Donor Profile Screen
  - Name
  - Username
  - Address/es
  - Contact No

  ? Can a profile be edited?

  

*/

import 'package:flutter/material.dart';

class DonorProfile extends StatefulWidget {
  const DonorProfile({super.key});

  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile"),
      // ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Text("User name")
            ),
            
            Text("Info"),
            Text("Info"),
            Text("Info"),
            Text("Info"),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Sign Out")
            )
          ],
        ),
      )
    );
  }
}