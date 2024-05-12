/*
  Donor Home Page - displays list of all organizations a donor can donate to
*/
import 'package:flutter/material.dart';

class DonorHome extends StatefulWidget {
  const DonorHome({super.key});

  @override
  State<DonorHome> createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  // Soon: Obtain organization list by Stream<QuerySnapshot>
  // Soon: Modify listview.builder wrapped around StreamBuilder

  // Possible Sample data using Provider
  // List<Org> orgs = context.watch<OrgList>().olist;
  // basic sample data (map)
  var orgs = {0:"Org 1", 1:"Org 2", 2:"Org 3"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
                  subtitle: Text("More organization info"),
                  onTap: () {
                    // Soon: Donate screen
                  },
                );
              }
            ),
          )
        ],
      )
    );
  }
}