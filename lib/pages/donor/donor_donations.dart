import 'package:flutter/material.dart';
import 'package:my_app/pages/donor/donation_detail.dart';


class DonorDonations extends StatefulWidget {
  const DonorDonations({super.key});

  @override
  State<DonorDonations> createState() => _DonorDonationsState();
}

class _DonorDonationsState extends State<DonorDonations> {
  // Soon: Obtain organization list by Stream<QuerySnapshot>
  // Soon: Modify listview.builder wrapped around StreamBuilder

  // Possible Sample data using Provider
  // List<Org> orgs = context.watch<OrgList>().olist;
  // basic sample data (map)
  var orgs = {0:"Donation 1", 1:"Donation 2", 2:"Donation 3"};


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donations"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: orgs.length,
              // Soon: itemBuilder: ((context, index) {})
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(orgs[index]!),
                  subtitle: Text("More donation info"),
                  onTap: () {
                    // Donation detail screen
                    // pass the donation id as args to retrieve info
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DDonationDetail()),
                    );
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