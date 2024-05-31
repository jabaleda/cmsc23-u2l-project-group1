import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/donation_drive.dart';
import 'package:my_app/pages/org/org_createDrive.dart';
import 'package:my_app/providers/drive_provider.dart';
import 'package:provider/provider.dart';

class OrganizationDrives extends StatefulWidget {
  const OrganizationDrives(this.email, {super.key});
  final String email;

  @override
  State<OrganizationDrives> createState() => _OrganizationDrivesState();
}

class _OrganizationDrivesState extends State<OrganizationDrives> {
  @override

  Widget build(BuildContext context) {
    Stream<QuerySnapshot> driveStream = context.watch<DriveProvider>().drives;
    return Scaffold(
      appBar: AppBar(
        title: Text("Drives"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: driveStream,
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
                  Text("Donation drives are empty")
                ],
              ),
            );
          }
        return(
          ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            DonationDrive drive = DonationDrive.fromJson(
              snapshot.data?.docs[index].data() as Map<String, dynamic>
            );

            if(widget.email == drive.org)
            {
              return ListTile(
              title: Text(drive.name!),
              trailing: IconButton(
                onPressed: () {
                  // consider show modal bottom sheet 
                  // delete drive ??
                },
                icon: Icon(Icons.more_horiz),
              ),
              onTap: () {
                showModalBottomSheet(context: context, builder: (_){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Text(drive.name!, style: TextStyle(fontSize: 20),),
                        Text(drive.desc!, style: TextStyle(fontSize: 20),),
                        Text("Donations:", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  );
                });
              },
            );
            }
            else{
              return(
                Container()
              );
            }
          },
          )); 
        },

        
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(248, 120, 8, 100),
        onPressed: () {
          // CRUD for Donation Drives
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateDonationDrive(widget.email)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}