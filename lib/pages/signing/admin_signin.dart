import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';


class AdminSignInPage extends StatefulWidget {
  const AdminSignInPage({super.key});

  @override
  State<AdminSignInPage> createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? user;
  String? password;
  bool showSignInErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              leading: IconButton(icon: const Icon(Icons.arrow_back),
                onPressed:() => Navigator.pop(context, false),
          )),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  usernameField,
                  passwordField,
                  submitButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Admin Sign In",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get usernameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Username"),
              hintText: "Enter your username here"),
          onSaved: (value) => setState(() => user = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid username";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password"),
              hintText: "******"),
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

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          String? message = await context.read<UserAuthProvider>().authService.signIn(user!, password!, context);

          print(message);
          print(showSignInErrorMessage);

          if (mounted) Navigator.pop(context);


          setState(() {
            if (message != null && message.isNotEmpty) {
              showSignInErrorMessage = true;
            } else {
              showSignInErrorMessage = false;
            }
          });
        }
      },
      child: const Text("Sign In"));

}
