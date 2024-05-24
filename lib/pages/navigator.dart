
//for navigating dependending on signin, authentication

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/admin_page.dart';
import 'package:my_app/pages/donor/donor_home.dart';
import 'package:my_app/pages/org/org_home.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import '../providers/auth_provider.dart';
import 'signing/signin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            return const SignInPage();//if no user
          }

          // if(snapshot.data?.type = "donor")
          // {
          //   return const DonorHome();
          // }

          // if(snapshot.data?.type = "org")
          // {
          //   return const OrganizationHome();
          // }

          if(snapshot.data?.email! == "aa@gmail.com")
          {
            
            return const AdminPage();
          }
          // if user is logged in
          print(snapshot.data);
          return const MyHomePage(title:"MyHomePage");
        });
  }
}
