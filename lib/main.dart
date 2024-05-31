import 'package:flutter/material.dart';
import 'package:my_app/pages/org/org_createDrive.dart';
import 'package:my_app/pages/navigator.dart';
import 'package:my_app/pages/org/org_home.dart';
import 'package:my_app/pages/org/org_profile.dart';
import 'package:my_app/providers/auth_provider.dart';
import 'package:my_app/providers/donation_provider.dart';
import 'package:my_app/providers/donor_provider.dart';
import 'package:my_app/providers/drive_provider.dart';
import 'package:my_app/providers/org_provider.dart';
import 'package:my_app/providers/usertype_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


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
        ChangeNotifierProvider(create: ((context) => DriveProvider())),
        ChangeNotifierProvider(create: ((context) => UsertypeProvider()))
      ],
      child: const MyApp(),
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
        // initial route set to HomePage, which gives SIGN IN page by default.
        // * NEW: Checks whether user signed in is donor or org or admin
        '/': (context) => const HomePage(),

        // '/organization': (context) => const OrganizationHome(),
        //'/organizationProfile': (context) => const OrganizationProfile(),
        // '/createDrive': (context) => const CreateDonationDrive(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
    );
  }
}


