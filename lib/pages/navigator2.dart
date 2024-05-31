//for navigating dependending on approval status

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/admin_page.dart';
import 'package:my_app/pages/donor/donor_home.dart';
import 'package:my_app/pages/navigator.dart';
import 'package:my_app/pages/org/org_home.dart';
import 'package:my_app/pages/signing/signin_page.dart';
import 'package:my_app/providers/org_provider.dart';
import 'package:my_app/providers/usertype_provider.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';


class HomePage2 extends StatefulWidget {
  const HomePage2(this.email, {super.key});
  final String email;

  @override
  State<HomePage2> createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
              // * future receives the approval status
              future: context.read<OrgProvider>().orgService.getOrgStatus(widget.email), 
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error encountered! ${snapshot.error}"),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const SignInPage();
                }
                
                // Testing
                // print("in new: $snapshot");
                // print("in new: ${snapshot.data}");
                if(snapshot.data == 'true'){//if true returns org home
                  return OrganizationHome(widget.email);
                }
                else if(snapshot.data == 'false'){//if false logs out user and goes back to signin page
                  context.read<UserAuthProvider>().signOut();
                  return Container();//need to return non null
                }
                else{
                  return HomePage();
                }
              }
    );
  }
}