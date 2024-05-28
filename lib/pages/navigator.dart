
//for navigating dependending on signin, authentication

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/organization.dart';
import 'package:my_app/pages/admin/admin_page.dart';
import 'package:my_app/pages/donor/donor_home.dart';
import 'package:my_app/pages/org/org_home.dart';
import 'package:my_app/pages/signing/signin_page.dart';
import 'package:my_app/providers/donor_provider.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import '../providers/auth_provider.dart';
import 'signing/signin_page.dart';
import '../../providers/auth_provider.dart';
import '../../providers/org_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;

    // Stream<QuerySnapshot> orgListStream = context.watch<OrgProvider>().orgs;

    // Future<bool> getEmail(String email) async {
    //   return context.read<UserAuthProvider>().getType(email);
    // }

    // Future<bool> myFunc() async => true;

    // void main() async {
    //   var value = await myFunc(); // value = true
    // }
    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {

          // Future<bool> value;
          // value = context.read<UserAuthProvider>().authService.getEmailOrg(snapshot.data?.email).isEmpty;
          // Future<bool> value2 = myFunc();

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

          // final docSnapshots = donors.docs;

          // for (var i in docSnapshots) {
          //     const doc = docSnapshots[i].data();

          //     
          // }

          if(snapshot.data?.email! == "aa@gmail.com")
          {
            
            return const AdminPage();
          }


          // return FutureBuilder(future: context.read<UserAuthProvider>().getType(snapshot.data?.email), builder: 
          // (context, snapshot){
          //   if (snapshot.hasError) {
          //     return Scaffold(
          //       body: Center(
          //         child: Text("Error encountered! ${snapshot.error}"),
          //       ),
          //     );
          //   } else if (snapshot.connectionState == ConnectionState.waiting) {
          //     return const Scaffold(
          //       body: Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //     );
          //   } else if (!snapshot.hasData) {
          //     return MyHomePage(title: "No data");//if no user
          //   }
          //    else if (snapshot.data == true)
          //   {
          //     return const DonorHome();
          //   }
          //   else
          //   {
          //     print("this is ${snapshot.data}");
          //     return const OrganizationHome();
          //   }
            
          // }
          // );
          
          // final authemail = snapshot.data?.email;

          // bool? value;
          // context.read<UserAuthProvider>().getType(authemail).then((result) => value = result);

          // if(context.read<UserAuthProvider>().getType(authemail) == )
          // {
          //   return const OrganizationHome();
          // }
          // else
          // {
          //   return const DonorHome();
          // }
          // if user is logged in
          // String? newemail = snapshot.data?.email!;
          print(snapshot.data);
          return const MyHomePage(title: "Navigator");
        });
  }
}
