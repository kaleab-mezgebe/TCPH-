// import 'package:flutter/material.dart';
// import 'admins/AdminHome.dart';
// import 'core Admin/CoreAdminHome.dart';
// import 'data collectors/DataCollectorHome.dart';
// import 'LoginPage.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Login Page',
//     home: LoginPage(),
//     routes: {
//       '/admin': (context) => AdminHome(),
//       '/core-admin': (context) => CoreAdminHome(),
//       '/data-collector': (context) => DataCollectorHome(),
//     },
//   ));
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: const Text("My First Flutter App"),
          ),
          body: const Center(
            child: Text("Hi All Flutter Developers"),
          ),
        ));
  }
}
