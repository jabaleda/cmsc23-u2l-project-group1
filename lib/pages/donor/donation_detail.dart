import 'package:flutter/material.dart';

class DDonationDetail extends StatefulWidget {
  const DDonationDetail({super.key});

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
          Placeholder()
        ],
      )
    );
  }
}