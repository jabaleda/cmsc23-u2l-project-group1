import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/signing/signup_donor_page.dart';
import 'package:my_app/pages/signing/admin_signin.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';



class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? user;
  String? password;
  bool showSignInErrorMessage = false;

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
                  usernameField,
                  passwordField,
                  submitButton, 
                  asAdminButton, 
                  asDonorButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign In",
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
          String? message = await context.read<AuthProvider>().authService.signIn(user!, password!, context);

          print(message);
          print(showSignInErrorMessage);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage(title: "Homepage")),
          );

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

  
  Widget get asAdminButton => TextButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSignInPage()));
    },
    child: Text("Sign in as Admin")
  );

  Widget get asDonorButton => TextButton(
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpDonor()));
    },
    child: Text("Dont have an account? Sign up")
  );

}
