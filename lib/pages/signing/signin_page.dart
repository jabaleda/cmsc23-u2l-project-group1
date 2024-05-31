import 'package:flutter/material.dart';
import 'package:my_app/pages/signing/signup_donor_page.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool showSignInErrorMessage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            height: constraints.maxHeight,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Spacer(),
                  // image
                  Spacer(flex: 3,),
                  Text("App Name"),
                  Spacer(flex: 2,),
                  heading,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(190, 239, 239, 239),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 207, 207, 207),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                            // offset: Offset(4.0, 4.0)
                          ),
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          emailField,
                          passwordField,
                          SizedBox(
                            width: double.maxFinite,
                            child: submitButton,
                          ),
                          asDonorButton
                        ],
                      ),
                    ),
                  ),
                  Spacer()
                  
                  
                ],
              )
            )
              

          )
        );
      }),
    );
  }


  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign In",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.alternate_email),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:  BorderRadius.all(Radius.circular(20.0)),
              ),
              label: Text("Email"),
              hintText: "Enter your email here"
            ),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid email";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.lock_open_outlined),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:  BorderRadius.all(Radius.circular(20.0)),
              ),
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
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 248, 120, 8),
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 16
        )
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          String? message = await context.read<UserAuthProvider>().authService.signIn(email!, password!, context);

          print(message);
          print(showSignInErrorMessage);

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


  Widget get asDonorButton => Padding(padding: const EdgeInsets.only(left: 30),
    child: Row(children: [
      Expanded(child: Text("Don't have an account?")) ,
      Expanded(
        child: TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpDonor()));
      },
      child: Text("Sign up instead")
    ),
      )
      ],),
  );


}