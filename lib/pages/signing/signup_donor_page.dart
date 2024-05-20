/*
  Sign up as Donor Page
  - idea: separate related data, make multi page form

*/
import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/signing/signup_org_page.dart';
import 'package:my_app/pages/signing/signin_page.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignUpDonor extends StatefulWidget {
  const SignUpDonor({super.key});

  @override
  State<SignUpDonor> createState() => _SignUpDonorState();
}

class _SignUpDonorState extends State<SignUpDonor> {
  // fields
  // formkey
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? username;
  String? email;
  String? password;
  String? address;
  String? contactNo;
  
  
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
                nameField,
                usernameField,
                addressField,
                contactNoField,
                submitButton,
                asOrgButton,
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
      "Sign Up as Donor",
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

  Widget get nameField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Name"), hintText: "Firstname  Middle Initial Lastname"),
      onSaved: (value) => setState(() => name = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your name";
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
          return "Please enter your username";
        }
        return null;
      },
    ),
  );

  Widget get addressField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration:
          const InputDecoration(border: OutlineInputBorder(), label: Text("Address"), hintText: "#,St.,Barangay,City"),
      onSaved: (value) => setState(() => address = value),
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
          const InputDecoration(border: OutlineInputBorder(), label: Text("Contact Number"), hintText: "09XXXXXXXXX"),
      onSaved: (value) => setState(() => contactNo = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your contact number";
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

        // Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "App Title")));
        if (mounted) Navigator.pop(context);
      }
      // add as valid user 
    },
    child: Text("Sign Up")
  );

  Widget get asOrgButton => TextButton(
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpOrg()));
    },
    child: Text("Sign Up as Org")
  );

  Widget get asAdminButton => TextButton(
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
    },
    child: Text("Already have an account? Sign in instead")
  );


}