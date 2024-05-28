// Organization Home Page
// Display list of donations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/donation.dart';
import 'package:my_app/pages/org/org_drives.dart';
import 'package:my_app/pages/org/org_profile.dart';
import 'package:my_app/providers/donation_provider.dart';
import 'package:provider/provider.dart';

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
    Stream<QuerySnapshot> donoStream = context.watch<DonorDonationProvider>().donations;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: 
        StreamBuilder(
          stream: donoStream,
          builder:(context, snapshot) {
            if(snapshot.hasError) {
              return Center(child: Text("Error! ${snapshot.error}"),);
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Donations are empty")
                  ],
                ),
              );
            }

            return(

        ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            Donation dono = Donation.fromJson(
              snapshot.data?.docs[index].data() as Map<String, dynamic>
            );
            return ListTile(
              title: Text(dono.donor),
              subtitle: Text(dono.status),
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
        )
            );
            },
        )

    );
  }
}