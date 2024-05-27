import 'package:flutter/material.dart';

import '../../models/donation.dart';

class DDonationDetail extends StatefulWidget {
  final Donation donation;
  const DDonationDetail(this.donation, {super.key});

  @override
  State<DDonationDetail> createState() => _DonationDetailState();
}

class _DonationDetailState extends State<DDonationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Different text"),
      ),
      body: Column(
        children: [
          Text(widget.donation.category),
          Text(widget.donation.weight),
          Text(widget.donation.unit),
          Text(widget.donation.pickUp.toString()),
          Text(widget.donation.status)
        ],
      )
    );
  }
}