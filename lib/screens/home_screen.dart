import 'package:flutter/material.dart';

import '../screens/verify_phone_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: Image.asset(
                'assets/images/protto-logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.15,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 45,
                color: Color(0xff403A35),
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
            ),
            const Text(
              'Bike Service at your Finger Tips',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                color: Color(0xff403A35),
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: FlatButton(
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(VerifyPhoneScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
