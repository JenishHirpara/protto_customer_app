import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protto_customer_app/screens/dashboard_screen.dart';

class VerifyPhoneScreen extends StatelessWidget {
  static const routeName = '/verify-phone';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Sign in',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: Image.network(
                'https://protto.in/mumbai/images/protto-logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              'Sign up to get best Bike Service Deals',
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.2,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Mobile No.'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Theme.of(context).primaryColor,
              height: 50,
              width: double.infinity,
              child: FlatButton(
                child: const Text(
                  'VERIFY PHONE NUMBER',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).
                  push(pageRouteBuilder());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  PageRouteBuilder pageRouteBuilder(){
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return DashBoardScreen();
      },
      transitionDuration:
      Duration(
          milliseconds: 500
      ),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
  }



}
