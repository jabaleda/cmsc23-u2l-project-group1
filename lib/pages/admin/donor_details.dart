import 'package:flutter/material.dart';
import '../../models/donor.dart';

class DonorDetail extends StatefulWidget {
  final Donor donor;
  const DonorDetail(this.donor, {super.key});

  @override
  State<DonorDetail> createState() => _DonorDetailState();
}

class _DonorDetailState extends State<DonorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.donor.name}'s Details"),
      ),
      body: Center(child:
      Column(
        children: [
          Text(widget.donor.name!),
          Text(widget.donor.username!),
          Text(widget.donor.email!),
          Text(widget.donor.address!),
          Text(widget.donor.contactNo!)
        ],
      )
      )
    );
  }
}