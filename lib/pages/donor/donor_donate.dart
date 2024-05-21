/*
  Donor donate screen
  - Form with fields:
    - checkbox (item category)
    - dropdown? or single select (pickup/drop-off)
    - numfield (item weight) with unit changer (kg/lbs)
    - OPTIONAL: photo
    - date and time (date of pick-up/drop-off)
    - text field (address for pick up only)
    - contact number (for pick up only)
    - generate QR (for drop-off only)
    
*/

import 'package:flutter/material.dart';

class DonorDonate extends StatefulWidget {
  const DonorDonate({super.key});

  @override
  State<DonorDonate> createState() => _DonorDonateState();
}

class _DonorDonateState extends State<DonorDonate> {
  final _formKey = GlobalKey<FormState>();
  // fields




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation Form")
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Placeholder()
              ],
            ),
          ),
        )
      )
    );
  }
}