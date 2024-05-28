import 'package:flutter/material.dart';
import 'package:my_app/models/donation.dart';
import 'package:my_app/providers/drive_provider.dart';
import 'package:provider/provider.dart';

class CreateDonationDrive extends StatefulWidget {
  const CreateDonationDrive({super.key});

  @override
  State<CreateDonationDrive> createState() => _CreateDonationDriveState();
}

class _CreateDonationDriveState extends State<CreateDonationDrive> {
  final _formKey = GlobalKey<FormState>();

  final _controller = TextEditingController();

  String? name;
  String? desc;
  List<Donation>? donations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Donation Drive"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text("Name")
                ),
                onSaved: (val) {
                  print("Text value: ${val!}");
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text("Description")
                ),
                onSaved: (val) {
                  print("Text value: ${val!}");
                },
                onChanged: (value) {
                  setState(() {
                    desc = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();

                    await context.read<DriveProvider>().driveService.addDrive(name!, desc!, donations!);

                    Navigator.pop(context);
                  }
                },
                child: Text("Create"),
              )
            ],
          ),
        ),
      ),
    );
  }
}