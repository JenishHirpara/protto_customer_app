import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './navigationBarScreen.dart';
import '../providers/profile.dart';
import './signup_screen.dart';
import '../models/http_exception.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static const routeName = '/verify-phone';

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  var _mobileController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _isLoading = false;

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
              child: Image.asset(
                'assets/images/protto-logo.png',
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
              child: Form(
                key: _form,
                child: TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(labelText: 'Mobile No.'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a mobile number';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Theme.of(context).primaryColor,
              height: 50,
              width: double.infinity,
              child: FlatButton(
                child: _isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : const Text(
                        'VERIFY PHONE NUMBER',
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () async {
                  final isValid = _form.currentState.validate();
                  if (!isValid) {
                    return;
                  }
                  try {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<UserProfile>(context, listen: false)
                        .getProfile(_mobileController.text);

                    Navigator.of(context).pushReplacement(pageRouteBuilder());
                  } on HttpException catch (_) {
                    Navigator.of(context).pushReplacementNamed(
                      SignupScreen.routeName,
                      arguments: _mobileController.text,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  PageRouteBuilder pageRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NavigationBarScreen();
      },
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
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
