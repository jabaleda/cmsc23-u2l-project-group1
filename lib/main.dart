import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/org/org_donationDetails.dart';
import 'package:my_app/pages/org/org_drives.dart';
import 'package:my_app/pages/org/org_home.dart';
import 'package:my_app/pages/org/org_profile.dart';
import 'package:my_app/pages/signing/admin_signin.dart';
import 'package:my_app/pages/signing/signup_donor_page.dart';
import 'pages/signing/admin_signin.dart';
import 'pages/signing/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // initial route set to HomePage, which gives SIGN IN page by default
        '/': (context) => const SignInPage(),

        '/organization': (context) => const OrganizationHome(),
        '/organizationProfile': (context) => const OrganizationProfile(),
        '/organizationDrives': (context) => const OrganizationDrives(),
        '/donationDetail': (context) => const DonationDetail(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
    );
  }
}



// E9 organization
/*
- main() -> async method
  - multiproviders
- widget build contains one route only 
  -> go to entry page.

*/
