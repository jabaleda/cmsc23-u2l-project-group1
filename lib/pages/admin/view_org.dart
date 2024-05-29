import 'package:flutter/material.dart';
// ignore: unused_import
import '../../models/organization.dart'; 


class ViewOrganization extends StatefulWidget {
  const ViewOrganization({super.key});

  @override
  State<ViewOrganization> createState() => _ViewOrganizationState();
}

class _ViewOrganizationState extends State<ViewOrganization> {

  var orgs = {0:"Org 1", 1:"Org 2"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organizations"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: orgs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(orgs[index]!),
                  subtitle: Text("Tap to view donations"),
                  onTap: () {
                  },
                );
              }
            ),
          )
        ],
      ),
    );
  
  }
}