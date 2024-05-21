import 'package:flutter/material.dart';

class OrganizationDrives extends StatefulWidget {
  const OrganizationDrives({super.key});

  @override
  State<OrganizationDrives> createState() => _OrganizationDrivesState();
}

class _OrganizationDrivesState extends State<OrganizationDrives> {
  String name = "McDonaldo";
  String desc = "One of the fast foods of all time";
  List<String> listOfDonations = [
    "Cheeseburger",
    "ChickenFillet"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drives"),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Donation Drive"),
            trailing: IconButton(
              onPressed: () {
                // consider show modal bottom sheet 
              },
              icon: Icon(Icons.more_horiz),
            ),
            onTap: () {
              showModalBottomSheet(context: context, builder: (_){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(name, style: TextStyle(fontSize: 20),),
                      Text(desc, style: TextStyle(fontSize: 20),),
                      Text("Donations:", style: TextStyle(fontSize: 20),),
                    ],
                  ),
                );
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // CRUD for Donation Drives
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}