import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/view_donation.dart';
import '../../models/organization.dart'; 
import 'package:provider/provider.dart';
import '../../providers/org_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OrgApproval extends StatefulWidget {
  const OrgApproval({super.key});

  @override
  State<OrgApproval> createState() => _OrgApprovalState();
}

class _OrgApprovalState extends State<OrgApproval> {

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> orgStream = context.watch<OrgProvider>().orgs;

      return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Organization Approval")
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
                        subtitle: Text("Grant access?"),
                        trailing: Checkbox(
                          value: org.statusApproved,
                          onChanged: (bool? value) {
                            context
                              .read<OrgProvider>()
                              .toggleStatus(org.id!, value!);
                          }
                         ),
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