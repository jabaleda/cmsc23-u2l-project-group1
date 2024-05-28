
import 'package:flutter/material.dart';
import 'package:my_app/pages/admin/donor_details.dart';
import 'package:my_app/pages/admin/view_donation.dart';
import '../../models/donor.dart'; 
import 'package:provider/provider.dart';
import '../../providers/donor_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ViewDonors extends StatefulWidget {
  const ViewDonors({super.key});

  @override
  State<ViewDonors> createState() => _ViewDonorState();
}

class _ViewDonorState extends State<ViewDonors> {

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> donors = context.watch<DonorProvider>().donors;

      return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("All Donors")
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: donors,
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


                  // * return donorlist display
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ( (context, index) {
                      // * Donor Object
                      Donor donor = Donor.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>
                      );

                      // * set id
                      donor.id = snapshot.data?.docs[index].id;

                      // * display
                      return ListTile(
                        title: Text("${donor.name}"),
                        subtitle: Text("View details"),
                        trailing: IconButton(
                          onPressed: null, 
                          icon: const Icon(Icons.delete_outlined)),
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DonorDetail(donor)),
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