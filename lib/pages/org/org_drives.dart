import 'package:flutter/material.dart';

class OrganizationDrives extends StatefulWidget {
  const OrganizationDrives({super.key});

  @override
  State<OrganizationDrives> createState() => _OrganizationDrivesState();
}

class _OrganizationDrivesState extends State<OrganizationDrives> {
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
                // consider DraggableScrollableSheet 
              },
              icon: Icon(Icons.more_horiz),
            ),
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