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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text("Donation Type: Food", style: TextStyle(fontSize: 20),),
              Text("Pickup", style: TextStyle(fontSize: 20),),
              Text("Weight(kg): 100", style: TextStyle(fontSize: 20),),
              Text("Date: 05/21/2024", style: TextStyle(fontSize: 20),),
              Text("Time: 4:00pm", style: TextStyle(fontSize: 20),),
            ],
          )
        ),
      )
    );
  }
}