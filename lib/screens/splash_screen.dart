import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      SizedBox(
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.15,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        width: double.infinity,
        child: Image.asset(
          'assets/images/protto-logo.png',
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      const Text(
        'Bike service at your Finger Tips',
        style: TextStyle(
          fontFamily: 'SourceSansPro',
          fontSize: 16,
          //color: Color(0xff403A35),
        ),
      ),
      SizedBox(
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.45,
      ),
      Text(
        'Loading...',
        style: TextStyle(
          fontFamily: 'SourceSansProSB',
          fontSize: 25,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ])));
  }
}
