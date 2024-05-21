import 'package:flutter/material.dart';

class CreateDonationDrive extends StatefulWidget {
  const CreateDonationDrive({super.key});

  @override
  State<CreateDonationDrive> createState() => _CreateDonationDriveState();
}

class _CreateDonationDriveState extends State<CreateDonationDrive> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Donation Drive"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          
        ),
      ),
    );
  }
}