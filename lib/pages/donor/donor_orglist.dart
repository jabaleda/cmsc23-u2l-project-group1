import 'package:flutter/material.dart';

class DonorOrgList extends StatefulWidget {
  const DonorOrgList({super.key});

  @override
  State<DonorOrgList> createState() => _DonorOrgListState();
}

class _DonorOrgListState extends State<DonorOrgList> {
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
        title: Text("App Name"),
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
                  subtitle: Text("More organization info"),
                  onTap: () {
                    // Soon: Donate screen
                    // DonorDonate()
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