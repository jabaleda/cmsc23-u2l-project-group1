/*
  Date created: 05/07/2024
  Sample Entry Page.
  This will be the Stream Builder that manages the 
  log-in/sign-up mechanism. For now, it simply directs user to
  the different views of the app.

*/


import 'package:flutter/material.dart';
import 'admin/admin_signin.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            toDonor, toOrg, toAdmin
          ],
        ),
      ),
    );
  }


  Widget get toDonor => Container(
    margin: const EdgeInsets.all(20),
    child: ElevatedButton(
      onPressed: () {
        // 
      }, 
      child: Text("Donor's View")
    ),
  );

  Widget get toOrg => Container(
    margin: const EdgeInsets.all(20),
    child: ElevatedButton(
      onPressed: () {
        // 
      }, 
      child: Text("Organization's View")
    ),
  );

  Widget get toAdmin => Container(
    margin: const EdgeInsets.all(20),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      }, 
      child: Text("Admin's View")
    ),
  );



}