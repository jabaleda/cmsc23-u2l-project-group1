
import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/org_approval.dart';
import 'view_org.dart';
import 'view_donor.dart';
import 'admin_signin.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Admin Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ViewOrg, ApproveOrg, ViewDonor
          ],
        ),
      ),
    );
  }


  Widget get ViewOrg => Container(
    margin: const EdgeInsets.all(20),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewOrganization()),
        );
      }, 
      child: Text("View All Organizations And Donations")
    ),
  );

  Widget get ApproveOrg => Container(
    margin: const EdgeInsets.all(20),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrgApproval()),
        );
      }, 
      child: Text("Approve Organization Sign-Ups")
    ),
  );

  Widget get ViewDonor => Container(
    margin: const EdgeInsets.all(20),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewDonors()),
        );
      }, 
      child: Text("View All Donors")
    ),
  );



}