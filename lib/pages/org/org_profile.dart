import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/organization.dart';
import 'package:my_app/pages/signing/signin_page.dart';
import 'package:my_app/providers/org_provider.dart';
import 'package:path/path.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class OrganizationProfile extends StatefulWidget {
  final String email;
  const OrganizationProfile(this.email, {super.key});

  @override
  State<OrganizationProfile> createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> orgStream = OrgProvider().findOrg(widget.email);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: orgStream,
          builder: (context, snapshot){
            if (snapshot.hasError) {
              return Center(
                child: Text("Error! ${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Donations are empty")],
                ),
              );
            }

            Organization org = Organization.fromJson(
              snapshot.data?.docs[0].data() as Map<String, dynamic>
            );

            return (
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle, size: 24,),
                      Text(
                        org.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Divider(
                  ),
                  Row(
                    children: [
                      Icon(Icons.edit, size: 24,),
                      Text(
                        org.about,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Divider(
                  ),
                  SwitchListTile(
                    title: Text("Status for Donation"),
                    value: org.statusDonation,
                    onChanged: (bool val) async {
                      context.read<OrgProvider>().toggleDonation(snapshot.data!.docs[0].id, val);
                    },
                  ),
                ],
              )
            );
          },
        )
      ),
    );
  }
}