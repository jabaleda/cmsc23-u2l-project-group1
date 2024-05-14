import 'package:flutter/material.dart';
import '../../models/organization.dart'; 


class ViewDonors extends StatefulWidget {
  const ViewDonors({super.key});

  @override
  State<ViewDonors> createState() => _ViewDonorsState();
}

class _ViewDonorsState extends State<ViewDonors> {

  var orgs = {0:"Donor 1", 1:"Donor 2"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donors"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: orgs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(orgs[index]!),
                  subtitle: Text("View Details"),
                  onTap: () {
                  },
                  trailing: IconButton(onPressed: null, icon: const Icon(Icons.delete) ),
                );
              }
            ),
          )
        ],
      ),
    );
  
  }
}