import 'package:flutter/material.dart';
import 'package:my_app/models/donation.dart';
import 'package:my_app/providers/drive_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class CreateDonationDrive extends StatefulWidget {
  const CreateDonationDrive(this.email, {super.key});
  final String email;

  @override
  State<CreateDonationDrive> createState() => _CreateDonationDriveState();
}

class _CreateDonationDriveState extends State<CreateDonationDrive> {
  final _formKey = GlobalKey<FormState>();

  final _controller = TextEditingController();

  String? name;
  String? desc;
  List<Donation>? donations = [];

  FirebaseStorage storage = FirebaseStorage.instance;

  // Future<void> _upload(String inputSource) async {
  //   final picker = ImagePicker();
  //   XFile? pickedImage;
    

  //   try {
  //     pickedImage = await picker.pickImage(
  //         source: inputSource == 'camera'
  //             ? ImageSource.camera
  //             : ImageSource.gallery,
  //         maxWidth: 1920);

  //     final String fileName = path.basename(pickedImage!.path);
  //     File imageFile = File(pickedImage.path);

  //     try {
  //       // Uploading the selected image with some custom meta data
  //       await storage.ref(fileName).putFile(
  //           imageFile,
  //           SettableMetadata(customMetadata: {
  //             'uploaded_by': widget.email,
  //             'description': 'Some description...'
  //           }));

  //       // Refresh the UI
  //       setState(() {});
  //     } on FirebaseException catch (error) {
  //       if (kDebugMode) {
  //         print(error);
  //       }
  //     }
  //   } catch (err) {
  //     if (kDebugMode) {
  //       print(err);
  //     }
  //   }
  // }

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
              ),
              // ElevatedButton.icon(
              //       onPressed: () => _upload('camera'),
              //       icon: const Icon(Icons.camera),
              //       label: const Text('camera')),
              // ElevatedButton.icon(
              //       onPressed: () => _upload('gallery'),
              //       icon: const Icon(Icons.library_add),
              //       label: const Text('Gallery')),      
            ],
          ),
        ),
      ),
    );
  }
}