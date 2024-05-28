import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/org/org_createDrive.dart';
import 'package:my_app/pages/navigator.dart';
import 'package:my_app/pages/org/org_donationDetails.dart';
import 'package:my_app/pages/org/org_drives.dart';
import 'package:my_app/pages/org/org_home.dart';
import 'package:my_app/pages/org/org_profile.dart';
import 'package:my_app/pages/signing/admin_signin.dart';
import 'package:my_app/pages/signing/signup_donor_page.dart';
import 'package:my_app/providers/auth_provider.dart';
import 'package:my_app/providers/donation_provider.dart';
import 'package:my_app/providers/donor_provider.dart';
import 'package:my_app/providers/drive_provider.dart';
import 'package:my_app/providers/org_provider.dart';
import 'package:provider/provider.dart';
import 'pages/signing/admin_signin.dart';
import 'pages/signing/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => DonorDonationProvider())),// providers
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
        ChangeNotifierProvider(create: ((context) => DonorProvider())),
        ChangeNotifierProvider(create: ((context) => OrgProvider())),
        ChangeNotifierProvider(create: ((context) => DriveProvider()))
      ],
      child: MyApp(),
    ),
  );
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
        '/': (context) => const HomePage(),

        '/organization': (context) => const OrganizationHome(),
        '/organizationProfile': (context) => const OrganizationProfile(),
        '/createDrive': (context) => const CreateDonationDrive(),
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
