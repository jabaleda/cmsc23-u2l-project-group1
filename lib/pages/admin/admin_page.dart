
import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/org_approval.dart';
import 'view_org.dart';
import 'view_donor.dart';
import '../signing/admin_signin.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {//home page
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Admin Page"),
      ),
      body: Container(color: Colors.orangeAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ViewOrg, ApproveOrg, ViewDonor //three button views
            ],
          ),
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

  Drawer get drawer => Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(padding: EdgeInsets.fromLTRB(16, 16, 16, 5),child: Center(child: Text("What do you want to do?"))),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            context.read<UserAuthProvider>().signOut();
            Navigator.pop(context);
          },
        ),
      ]));

}