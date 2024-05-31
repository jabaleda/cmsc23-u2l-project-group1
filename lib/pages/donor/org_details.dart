/* 
  * Details page of Organization
*/

import 'package:flutter/material.dart';
import 'package:my_app/models/organization.dart';

import 'donor_donate.dart';

class OrgDetails extends StatefulWidget {
  final Organization org;
  final String donorEmail;
  const OrgDetails(this.org, this.donorEmail, {super.key});

  @override
  State<OrgDetails> createState() => _OrgDetailsState();
}

class _OrgDetailsState extends State<OrgDetails> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("@${widget.org.username}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.org.name),
            Text(widget.org.about),
            // Text(widget.org.address[0]),
            Text(widget.org.contactNo),

            ElevatedButton(
              onPressed: () {
                // * redirect to donation form
                // * pass org id, 
                // ! NOTE: Needs a unique donor identifier (id, email, username)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorDonate(widget.org, widget.donorEmail)),
                );
              }, 
              child: Text("Donate")
            )
          ],
        ),
      ),
    );
  }
}