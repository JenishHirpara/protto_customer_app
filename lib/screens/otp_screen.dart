import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './signup_screen.dart';
import '../providers/profile.dart';
import './navigationBarScreen.dart';

class OtpScreen extends StatefulWidget {
  final String text;

  OtpScreen(this.text);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _form = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  var _digit1;
  var _digit2;
  var _digit3;
  var _digit4;

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (widget.text == 'login') {
      if ('$_digit1$_digit2$_digit3$_digit4' ==
          Provider.of<UserProfile>(context, listen: false).dummyItem.otp) {
        await Provider.of<UserProfile>(context, listen: false).setProfile();
        Navigator.of(context).pushReplacement(pageRouteBuilder());
      } else {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Invalid OTP'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'),
                ),
              ],
            );
          },
        );
      }
    } else {
      if ('$_digit1$_digit2$_digit3$_digit4' ==
          Provider.of<UserProfile>(context, listen: false).signupOtp) {
        Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
      } else {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Invalid OTP'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  PageRouteBuilder pageRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NavigationBarScreen();
      },
      transitionDuration: Duration(milliseconds: 300),
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

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      FocusScope.of(context).requestFocus(_focusNode1);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Color.fromRGBO(230, 230, 230, 1),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top,
              width: double.infinity,
              color: Color.fromRGBO(230, 230, 230, 1),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height:
                      (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
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
                  height:
                      (mediaQuery.size.height - mediaQuery.padding.top) * 0.15,
                ),
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0xff403A35),
                    //fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: const Text(
                    'A 4-Digit PIN has been sent to your mobile. Enter it below to continue',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xff403A35),
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _form,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 45.0,
                          height: 45.0,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            focusNode: _focusNode1,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode2);
                              }
                            },
                            onSaved: (value) {
                              _digit1 = value;
                            },
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: 45.0,
                          height: 45.0,
                          alignment: Alignment.center,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            focusNode: _focusNode2,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode3);
                              } else {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode1);
                              }
                            },
                            onSaved: (value) {
                              _digit2 = value;
                            },
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: 45.0,
                          height: 45.0,
                          alignment: Alignment.center,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            focusNode: _focusNode3,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode4);
                              } else {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode2);
                              }
                            },
                            onSaved: (value) {
                              _digit3 = value;
                            },
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: 45.0,
                          height: 45.0,
                          alignment: Alignment.center,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            maxLength: 1,
                            focusNode: _focusNode4,
                            onSaved: (value) {
                              _digit4 = value;
                            },
                            onChanged: (value) {
                              if (value.isEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode3);
                              }
                            },
                            onFieldSubmitted: (_) => _saveForm(),
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  width: double.infinity,
                  height: 45,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _saveForm,
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
