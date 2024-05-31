/*

*/

/*
  Sign up as Donor Page
  - idea: separate related data, make multi page form

*/

import 'package:flutter/material.dart';
import 'package:my_app/pages/signing/signup_donor_page.dart';
import 'package:my_app/providers/usertype_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/org_provider.dart';
import 'package:file_picker/file_picker.dart';

class SignUpOrg extends StatefulWidget {
  const SignUpOrg({super.key});

  @override
  State<SignUpOrg> createState() => _SignUpOrgState();
}

class _SignUpOrgState extends State<SignUpOrg> {
  // fields
  // formkey
  final _formKey = GlobalKey<FormState>();

  String? orgname;
  String? username;
  String? email;
  String? password;
  String? address;
  String? contactNo;
  String? proof;
  String? about;
  FilePickerResult? result;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                heading,
                emailField,
                passwordField,
                orgnameField,
                usernameField,
                addressField,
                contactNoField,
                aboutField,
                proofField,
                submitButton,
                asDonorButton,
                asAdminButton
              ],
            )
          ),
        )
      )
    );
  }

  Widget get heading => const Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: Text(
      "Sign Up as Org",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  );

  Widget get emailField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Email"), hintText: "juandelacruz09@gmail.com"),
      onSaved: (value) => setState(() => email = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        }
        return null;
      },
    ),
  );

  Widget get passwordField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Password"), hintText: "******"),
      obscureText: true,
      onSaved: (value) => setState(() => password = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        return null;
      },
    ),
  );
  Widget get orgnameField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Organization Name"), hintText: "McDonalds"),
      onSaved: (value) => setState(() => orgname = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your organization name";
        }
        return null;
      },
    ),
  );

  Widget get usernameField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Username"), hintText: "juandelacruz09@gmail.com"),
      onSaved: (value) => setState(() => username = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your usernamme";
        }
        return null;
      },
    ),
  );

  Widget get addressField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Address"), hintText: "#, St., Barangay, City"),
      onSaved: (value) => setState(() => address = value!),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your address";
        }
        return null;
      },
    ),
  );

  Widget get contactNoField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Contact number"), hintText: "09XXXXXXXXX"),
      onSaved: (value) => setState(() => contactNo = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your contact number";
        }
        return null;
      },
    ),
  );

  Widget get proofField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Proof"), hintText: "drive.google.XXXXXXXXX"),
      onSaved: (value) => setState(() => proof = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your proof";
        }
        return null;
      },
    ),
  );

  Widget get aboutField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("About"), hintText: "What is the organization about?"),
      onSaved: (value) => setState(() => about = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your about info";
        }
        return null;
      },
    ),
  );

  // other fields


  Widget get submitButton => ElevatedButton(
    onPressed: () async {
      if(_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // test
        await context
          .read<UserAuthProvider>()
          .authService
          .signUp(email!, password!);


        await context
          .read<OrgProvider>()
          .orgService
          .addOrg(email!, orgname!, username!, address!, contactNo!, about!, proof!);


        await context
              .read<UsertypeProvider>()
              .typeService
              .addUser(email!, "org");


        if (mounted){
          Navigator.pop(context);
        }
      }
      // add as valid user 
    },
    child: Text("Sign Up")
  );

  Widget get asDonorButton => TextButton(
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpDonor()));
    },
    child: Text("Sign Up as Donor")
  );

  Widget get asAdminButton => Padding(
    padding: const EdgeInsets.only(left: 30),
    child: Row(children: [
      const Text("Already have an account?"),
      TextButton(
      onPressed: () {
        Navigator.pop(context);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
      },
      child: Text("Sign in instead")
    )],),
  );


}