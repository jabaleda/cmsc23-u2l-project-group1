import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/donor/donation_detail.dart';
import 'package:provider/provider.dart';

import '../../models/donation.dart';
import '../../providers/donation_provider.dart';


class DonorDonations extends StatefulWidget {
  final String donorEmail;
  const DonorDonations(this.donorEmail, {super.key});

  @override
  State<DonorDonations> createState() => _DonorDonationsState();
}

class _DonorDonationsState extends State<DonorDonations> {

  @override
  Widget build(BuildContext context) {

    // fetch donations specific to widget.donorEmail
    Stream<QuerySnapshot> donationListStream = context.watch<DonorDonationProvider>().firebaseService.getTheseDonations(widget.donorEmail);
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Donations"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
             child: Container(
              child: StreamBuilder(
                stream: donationListStream,
                builder: (context, snapshot) {
                  // check if empty
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
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }

                  // return donation list display
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ( (context, index) {
                      // Donation object
                      Donation donation = Donation.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>
                      );

                      // set id
                      donation.id = snapshot.data?.docs[index].id;

                      // display
                      return ListTile(
                        title: Text("Donation for ${donation.orgname}"),
                        subtitle: Text(donation.category),

                        onTap: () {
                          // Donation detail screen
                          // pass the donation id as args to retrieve info
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DDonationDetail(donation)),
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


// Flexible(
//             child: ListView.builder(
//               itemCount: orgs.length,
//               // Soon: itemBuilder: ((context, index) {})
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(orgs[index]!),
//                   subtitle: Text("More donation info"),
//                   onTap: () {
//                     // Donation detail screen
//                     // pass the donation id as args to retrieve info
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => DDonationDetail()),
//                     );
//                   },
//                 );
//               }
//             ),
//           )