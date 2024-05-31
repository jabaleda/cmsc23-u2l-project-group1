import 'package:flutter/material.dart';
import '../../models/donor.dart';

class DonorDetail extends StatefulWidget {
  final Donor donor;
  const DonorDetail(this.donor, {super.key});

  @override
  State<DonorDetail> createState() => _DonorDetailState();
}

class _DonorDetailState extends State<DonorDetail> {//page for details of donor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.donor.name}'s Details"),
      ),
      body: Center(child:
      Column(
        children: [
          Text('Name: ${widget.donor.name!}'),
          Text('Username: ${widget.donor.username!}'),
          Text('Email: ${widget.donor.email!}'),
          Text('Address: ${widget.donor.address!}'),
          Text('Contact Number: ${widget.donor.contactNo!}')

        ],
      )
      )
    );
  }
}