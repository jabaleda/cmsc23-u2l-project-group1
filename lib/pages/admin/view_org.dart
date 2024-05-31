import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/view_donation.dart';
import '../../models/organization.dart'; 
import 'package:provider/provider.dart';
import '../../providers/org_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ViewOrganization extends StatefulWidget {
  const ViewOrganization({super.key});

  @override
  State<ViewOrganization> createState() => _ViewOrganizationState();
}

class _ViewOrganizationState extends State<ViewOrganization> {

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> orgStream = context.watch<OrgProvider>().openOrgs;

      return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("All Organizations")
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: orgStream,
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
                        title: Text("${org.name}"),
                        subtitle: Text("View donations"),
                        onTap: () {
                          // * redirect to donations screen
                          // * pass org id, 
                          // ! NOTE: Needs a unique donor identifier (id, email, username)

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Donations(org.email, org.name)),
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