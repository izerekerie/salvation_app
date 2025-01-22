import 'package:flutter/material.dart';
import 'package:salvation_app/screens/Login.dart';
import 'package:salvation_app/screens/SignUp.dart';
import 'package:salvation_app/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Homepage()
      },
    );
  }
}
