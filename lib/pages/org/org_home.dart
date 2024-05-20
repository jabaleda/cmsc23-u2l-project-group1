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
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              // go to profile screen ?
              Navigator.pushNamed(context, "/organizationProfile")
            }, 
            icon: Icon(Icons.account_circle_sharp),
            )
        ],
      ),
      drawer: const OrgDrawer(),
      body: const DonationList(),
      bottomNavigationBar: const OrgBotNav(),
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
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("McDonalds"),
          subtitle: Text("Pending"),
          trailing: IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.more_horiz),
          ),
          onTap: () {
            Navigator.pushNamed(context, "/donationDetail");
          },
        );
      }
    );
  }
}

class OrgBotNav extends StatefulWidget {
  const OrgBotNav({super.key});

  @override
  State<OrgBotNav> createState() => _OrgBotNavState();
}

class _OrgBotNavState extends State<OrgBotNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Home"
        ),
      ],
    );
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
          const UserAccountsDrawerHeader(
            accountName: Text("Organization Name"),
            accountEmail: Text("bingbong@org.com"),
            currentAccountPicture: Icon(Icons.account_circle, size: 72,),
          ),
          ListTile(
            title: Text("Donation Drives"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/organizationDrives");
            },
          ),
        ],
      ),
    );
  }
}