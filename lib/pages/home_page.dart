// /*
//   Date created: 05/07/2024
//   Sample Entry Page.
//   This will be the Stream Builder that manages the 
//   log-in/sign-up mechanism. For now, it simply directs user to
//   the different views of the app.


//   * 05/30/2024 - Unused file. For deletion
// */

// import 'package:flutter/material.dart';
// import 'package:my_app/pages/donor/donor_home.dart';
// import '../../providers/auth_provider.dart';
// import 'package:provider/provider.dart';


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.

//     return Scaffold(
//       drawer: drawer,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             toDonor, toOrg
//           ],
//         ),
//       ),
//     );
//   }


//   Widget get toDonor => Container(
//     margin: const EdgeInsets.all(20),
//     child: ElevatedButton(
//       onPressed: () {
//         //
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DonorHome())
//         );
//       }, 
//       child: Text("Donor's View")
//     ),
//   );

//   Widget get toOrg => Container(
//     margin: const EdgeInsets.all(20),
//     child: ElevatedButton(
//       onPressed: () {
//         Navigator.pushNamed(context, "/organization");
//       }, 
//       child: Text("Organization's View")
//     ),
//   );

//   // Widget get toAdmin => Container(    //removed as admin is already at sign in
//   //   margin: const EdgeInsets.all(20),
//   //   child: ElevatedButton(
//   //     onPressed: () {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => const SignInPage()),
//   //       );
//   //     }, 
//   //     child: Text("Admin's View")
//   //   ),
//   // );

//   Drawer get drawer => Drawer(
//           child: ListView(padding: EdgeInsets.zero, children: [
//         const DrawerHeader(padding: EdgeInsets.fromLTRB(16, 16, 16, 5),child: Center(child: Text("What do you want to do?"))),
//         ListTile(
//           title: const Text('Logout'),
//           onTap: () {
//             context.read<UserAuthProvider>().signOut();
//             Navigator.pop(context);
//           },
//         ),
//       ]));
// }


// // E9 Organization: Entry Page
// /*
// In state:
// - widget build: obtain user stream to determine if:
//   - a user is logged in -> go to App Proper
//   - no user is logged in -> redirect to Sign In Page

// */

