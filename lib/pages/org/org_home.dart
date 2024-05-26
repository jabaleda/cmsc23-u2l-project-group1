// Organization Home Page
// Display list of donations
import 'package:flutter/material.dart';
import 'package:my_app/pages/org/org_drives.dart';
import 'package:my_app/pages/org/org_profile.dart';

class OrganizationHome extends StatefulWidget {
  const OrganizationHome({super.key});

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  static List<Widget> pages = <Widget>[
    DonationList(),
    OrganizationDrives(),
    OrganizationProfile(),
  ];

  int currIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currIndex],
      bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox_rounded),
          label: "Drives"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: "Profile"
        ),
      ],
      currentIndex: currIndex,
      onTap: onItemTapped
      ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: 
        ListView.builder(
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
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Text(
                              "Donation Type: Food",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Pickup",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Weight(kg): 100",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Date: 05/21/2024",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Time: 4:00pm",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    });
              },
            );
          }
        ),
    );
  }
}