import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/organization.dart';
import 'package:provider/provider.dart';

import '../../providers/org_provider.dart';
import 'org_details.dart';

class DonorOrgList extends StatefulWidget {
  final String donorEmail;
  const DonorOrgList(this.donorEmail, {super.key});

  @override
  State<DonorOrgList> createState() => _DonorOrgListState();
}

class _DonorOrgListState extends State<DonorOrgList> {
  @override
  Widget build(BuildContext context) {

    // * fetching of orglist
    // ! Fetch only the orgs approved - statusApproved: true
    Stream<QuerySnapshot> orgListStream = context.watch<OrgProvider>().approvedOrgs;

    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: orgListStream,
                builder: (context, snapshot) {
                  // * check if empty
                  if(snapshot.data?.size == 0) {
                    return Center(child: Text("No data :("));
                  } else {
                    if (snapshot.hasError) {
                      print("There's an error.");
                      return Center(
                        child: Text("Error encountered! ${snapshot.error}"),
                      );
                    } else if(snapshot.connectionState == ConnectionState.waiting) {
                      print(snapshot.connectionState);
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }


                  // * return org list display
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ( (context, index) {
                      // * Org Object
                      Organization org = Organization.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>
                      );

                      // * set id
                      org.id = snapshot.data?.docs[index].id;

                      // * display
                      return ListTile(
                        title: Text("For ${org.name}"),
                        subtitle: Text("Org description"),
                        onTap: () {
                          // * NEW: Display Org Details first
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrgDetails(org, widget.donorEmail))
                          );
                        },
                      );
                    })
                  );

                },
              ),
            ),
          )
        ],
      ),
    );
  
  }
}


//  Flexible(
//             child: ListView.builder(
//               itemCount: orgs.length,
//               // Soon: itemBuilder: ((context, index) {})
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(orgs[index]!),
//                   subtitle: Text("More organization info"),
//                   onTap: () {
//                     // Donate screen
//                     // Pass org name as args
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => DonorDonate()),
//                     );
//                   },
//                 );
//               }
//             ),
//           )