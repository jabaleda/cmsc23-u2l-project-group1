import 'package:flutter/material.dart';

class DonationDetail extends StatefulWidget {
  const DonationDetail({super.key});

  @override
  State<DonationDetail> createState() => _DonationDetailState();
}

class _DonationDetailState extends State<DonationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation"),
      ),
    );
  }
}