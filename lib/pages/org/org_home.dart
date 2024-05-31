// Organization Home Page
// Display list of donations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/donation.dart';
import 'package:my_app/models/donation_drive.dart';
import 'package:my_app/pages/org/org_drives.dart';
import 'package:my_app/pages/org/org_profile.dart';
import 'package:my_app/providers/auth_provider.dart';
import 'package:my_app/providers/donation_provider.dart';
import 'package:my_app/providers/drive_provider.dart';
import 'package:provider/provider.dart';

class OrganizationHome extends StatefulWidget {
  const OrganizationHome(this.email, {super.key});
  final String email;

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  late String getEmail;

  // @override
  //     void initState() {
  //     super.initState();
  //     getEmail = widget.email;
  //   }
  

  static List<Widget> pages = <Widget>[];

  int currIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currIndex = index;
    });
  }

  @override
  void initState() {
      super.initState();
      pages = <Widget>[
      DonationList(widget.email),
      OrganizationDrives(widget.email),
      OrganizationProfile(widget.email),
      ];
    }
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(248, 120, 8, 100),
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
  final String email;
  const DonationList(this.email, {super.key});

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donoStream = context.watch<DonorDonationProvider>().donations;
    Stream<QuerySnapshot> driveStream = context.watch<DriveProvider>().drives;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: 
        StreamBuilder(
          stream: donoStream,
          builder: (context, snapshot) {
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

            return (
              ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Donation dono = Donation.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>
                  );
                  String donoId = snapshot.data!.docs[index].id;
                  if(dono.org == widget.email){
                    return ListTile(
                      title: Text(dono.donor),
                      subtitle: Text(dono.status),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Select Donation Drive"),
                                content: Container(
                                  height: 300,
                                  width: 300,
                                  child:
                                  StreamBuilder(
                                  stream: driveStream,
                                  builder: (context, snapshot){
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              "Error! ${snapshot.error}"),
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child:
                                              CircularProgressIndicator(),
                                        );
                                      } else if (!snapshot.hasData) {
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Donations are empty")
                                            ],
                                          ),
                                        );
                                      }

                                      return (
                                        ListView.builder(
                                          itemCount: snapshot.data?.docs.length,
                                          itemBuilder: (context, index){
                                            DonationDrive drive = DonationDrive.fromJson(
                                              snapshot.data?.docs[index].data() as Map<String, dynamic>
                                            );
                                            return (
                                              ListTile(
                                                title: Text(drive.name!),
                                                onTap: () async {
                                                  await context.read<DriveProvider>().driveService.addDonation(donoId, snapshot.data!.docs[index].id);
                                                },
                                              )
                                            );
                                          },
                                        )
                                      );
                                  })
                              ));
                            }
                          );
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
                                      "Donation Type: ${dono.category}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      dono.pickUp ? "Pickup" : "Drop-off",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Weight(${dono.unit}): ${dono.weight}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Date: ${dono.date}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  }
                  else {
                    return Container();
                  }
                })
            );
          },
        )
    );
  }
}