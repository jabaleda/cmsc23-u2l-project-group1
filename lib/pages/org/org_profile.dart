import 'package:flutter/material.dart';
import 'package:my_app/pages/signing/signin_page.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class OrganizationProfile extends StatefulWidget {
  const OrganizationProfile({super.key});

  @override
  State<OrganizationProfile> createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text("Organization Name"),
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc iaculis mauris id dui scelerisque volutpat. Vestibulum enim dolor, consequat a nibh malesuada, egestas porta ex. Suspendisse eu elit ex. Vivamus et iaculis mi. Nam ornare augue id efficitur semper. Donec volutpat justo nec eleifend placerat. Nunc eros erat, faucibus eget feugiat id, posuere vitae leo. Nulla augue mi, varius quis dapibus quis, eleifend at augue. Nunc sagittis eget felis in pulvinar. Quisque pellentesque vitae velit nec tempus. "),
          TextButton(
            onPressed: () {
              // Navigator.pop(context);
              context.read<UserAuthProvider>().signOut();
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
            }, 
            child: Text("Sign Out"))
        ],
      ),
    );
  }
}