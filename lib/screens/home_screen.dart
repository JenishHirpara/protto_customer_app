import 'package:flutter/material.dart';
import 'package:protto_customer_app/screens/verify_phone_screen.dart';

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
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Theme.of(context).primaryColor,
              height: 50,
              width: double.infinity,
              child: FlatButton(
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      fontFamily: 'SourceSansProSB', color: Colors.white),
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
