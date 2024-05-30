
//for navigating dependending on signin, authentication

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/admin_page.dart';
import 'package:my_app/pages/donor/donor_home.dart';
import 'package:my_app/pages/org/org_home.dart';
import 'package:my_app/pages/signing/signin_page.dart';
import 'package:my_app/providers/usertype_provider.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // * fetch current user info
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;

    return StreamBuilder(
        stream: userStream,
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
            return const SignInPage();  // * if no user
          }

          // * NEW: Get current user email from Stream ----------
          // final user = FirebaseAuth.instance.currentUser;
          // print("user email: ${user?.email}");
          String? email = snapshot.data!.email;
          print("user email: ${snapshot.data!.email}");

          if(snapshot.data?.email! == "aa@gmail.com"){
            // * user is admin
            return const AdminPage();
          } else {
            // * check if user email is donor or org type by FutureBuilder
            return FutureBuilder(
              // * future receives the user type
              future: context.read<UsertypeProvider>().typeService.getThisUser(email!), 
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
                  return const SignInPage();//if no user
                }
                
                // Testing
                // print("in new: $snapshot");
                // print("in new: ${snapshot.data}");

                if(snapshot.data == "donor"){
                  return DonorHome();
                }else if(snapshot.data == "org"){
                  return OrganizationHome(email);
                }else{
                  return const SignInPage();
                }
              }
            );
            return const SignInPage();
          }
          // * NEW end ---------

        });
  }
}
