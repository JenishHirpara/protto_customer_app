import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/verify_phone_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protto',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        VerifyPhoneScreen.routeName: (ctx) => VerifyPhoneScreen(),
      },
    );
  }
}
