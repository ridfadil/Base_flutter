import 'package:flutter/material.dart';
import 'package:flutter_base_project/pages/views/splashscreen.dart';
import 'package:flutter_base_project/pages/views/student.dart';

import 'auth/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BASE FLUTTER 2",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.blueAccent,
      ),
      home: SplashScreen(),
      routes: {
        'login': (context) => Login(),
        'dashboard': (context) => StudentActivity(),
      },
    );
  }
}
