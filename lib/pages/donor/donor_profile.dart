/*
  Donor Profile Screen
  - Name
  - Username
  - Address/es
  - Contact No

  ? Can a profile be edited?

  

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/donor.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/donor_provider.dart';

class DonorProfile extends StatefulWidget {
  final String email;
  const DonorProfile(this.email, {super.key});

  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  @override
  Widget build(BuildContext context) {

    // Fetch single user
    Stream<QuerySnapshot> thisUserStream = context.watch<DonorProvider>().donorService.getThisDonor(widget.email);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: thisUserStream,
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

                  Donor donor = Donor.fromJson(
                    snapshot.data?.docs[0].data() as Map<String, dynamic>
                  );

                  donor.id = snapshot.data?.docs[0].id;

                  print("address items: ${donor.address.length}");

                  return Column(
                    children: [
                      Text(donor.name),
                      Text(donor.username),
                      Text(donor.contactNo),
                      Text(donor.address[0]),
                      TextButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          context.read<UserAuthProvider>().signOut();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                        }, 
                        child: Text("Sign Out")
                      )

                    ],
                  );

                }
                
              ),
            ),
          )
        ],
      ),
    );
  }
}




// return Scaffold(
//       // appBar: AppBar(
//       //   title: Text("Profile"),
//       // ),
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(30),
//               child: Text("User name")
//             ),
            
//             Text("Info"),
//             Text("Info"),
//             Text("Info"),
//             Text("Info"),
//             TextButton(
//               onPressed: () {
//                 // Navigator.pop(context);
//                 context.read<UserAuthProvider>().signOut();
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
//               }, 
//               child: Text("Sign Out")
//             )
//           ],
//         ),
//       )
//     );