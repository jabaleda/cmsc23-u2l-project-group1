import 'package:flutter/material.dart';
import '../../models/organization.dart';

class ViewOrganization extends StatefulWidget {
  const ViewOrganization({super.key});
  @override
  _ViewOrganizationState createState() => _ViewOrganizationState();
}

class _ViewOrganizationState extends State<ViewOrganization> {
  // Organization? org;

  @override
  Widget build(BuildContext context) {

    
    // Organization details = Organization.fromJson(org as Map<String, dynamic>);
  
    
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Organizations and Donations"),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Name:",
                  style: TextStyle(fontSize: 20),
                ),
                // Text(org!.name!, style: const TextStyle(fontSize: 20)),
                const Text(
                  "About:",
                  style: TextStyle(fontSize: 20),
                ),
                // Text(org!.about!, style: const TextStyle(fontSize: 20)),
            

                // Container(child: org!.status ? Text("True", style: const TextStyle(fontSize: 20)): Text("False", style: const TextStyle(fontSize: 20)))
                
              ],
            ),
          ),
        ));
  }
}