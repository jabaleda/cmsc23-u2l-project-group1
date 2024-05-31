import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/donor/donation_detail.dart';
import 'package:provider/provider.dart';

import '../../models/donation.dart';
import '../../providers/donation_provider.dart';


class Donations extends StatefulWidget {
  const Donations(this.email, this.name,{super.key});
  final String? email;
  final String name;

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  @override
  Widget build(BuildContext context) {

    // fetch
    Stream<QuerySnapshot> donations = context.watch<DonorDonationProvider>().donations;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Donations")
      ),
      body: Column(
        children: [
          Expanded(
             child: Container(
              child: StreamBuilder(
                stream: donations,
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
                      if(donation.org == widget.email)
                      {
                        return ListTile(
                          title: Text("From ${donation.donor} on ${donation.date}"),
                          subtitle: Text("See details"),

                          onTap: () {
                            // Donation detail screen
                            // pass the donation id as args to retrieve info
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DDonationDetail(donation)),
                            );
                          },
                        );
                      }
                      else
                      {
                        return Container();
                      }
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
