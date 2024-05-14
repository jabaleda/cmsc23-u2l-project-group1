import 'package:flutter/material.dart';
import '../../models/organization.dart'; 


class OrgApproval extends StatefulWidget {
  const OrgApproval({super.key});

  @override
  State<OrgApproval> createState() => _OrgApprovalState();
}

class _OrgApprovalState extends State<OrgApproval> {

  var orgs = {0:"YSES", 1:"COSS", 2:"ACSS", 3:"MASS"};
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organizations for approval"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: orgs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(orgs[index]!),
                  trailing: Checkbox(
                    value: value,
                    onChanged: (bool? newvalue) {
                      setState(() {
                        value = newvalue;
                      });
                    },
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  
  }
}