// Organization Home Page
// Display list of donations
import 'package:flutter/material.dart';

class OrganizationHome extends StatefulWidget {
  const OrganizationHome({super.key});

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organization Name"),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              // go to profile screen ?
            }, 
            icon: Icon(Icons.account_circle_sharp),
            )
        ],
      ),
      drawer: const OrgDrawer(),
      body: const DonationList(),
    );
  }
}

class DonationList extends StatefulWidget {
  const DonationList({super.key});

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class OrgDrawer extends StatefulWidget {
  const OrgDrawer({super.key});

  @override
  State<OrgDrawer> createState() => _OrgDrawerState();
}

class _OrgDrawerState extends State<OrgDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Organization Name")),
          ListTile(
            title: Text("Donation Drives"),
            onTap: () => {
              // pop
              // pushNamed
            },
          ),
        ],
      ),
    );
  }
}