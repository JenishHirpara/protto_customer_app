import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './otp_screen.dart';
import '../providers/profile.dart';
import '../models/http_exception.dart';
import './no_internet_screen.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static const routeName = '/verify-phone';

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  var _mobileController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _isLoading = false;
  var _isInternet = true;

  void retry() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<UserProfile>(context, listen: false)
          .getProfile(_mobileController.text);
      setState(() {
        _isInternet = true;
      });
      Navigator.of(context).pushReplacement(pageRouteBuilder('login'));
    } on HttpException catch (_) {
      Navigator.of(context).pushReplacement(pageRouteBuilder('signup'));
    } catch (error) {
      print(error.message);
      if (error.message.toString().contains('Failed host lookup')) {
        setState(() {
          _isLoading = false;
          _isInternet = false;
        });
      }
    }
  }

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
      body: _isInternet
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.05,
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
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.05,
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
                    height: 10,
                  ),
                  const Text(
                    'Sign up to get best Bike Service Deals',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      color: Color(0xff403A35),
                    ),
                  ),
                  SizedBox(
                    height:
                        (mediaQuery.size.height - mediaQuery.padding.top) * 0.2,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _form,
                      child: TextFormField(
                        controller: _mobileController,
                        decoration: InputDecoration(
                          labelText: 'Mobile No. (10 - digit)',
                          labelStyle: TextStyle(
                            fontFamily: 'SourceSansPro',
                          ),
                        ),
                        onFieldSubmitted: (_) async {
                          final isValid = _form.currentState.validate();
                          if (!isValid) {
                            return;
                          }
                          try {
                            setState(() {
                              _isLoading = true;
                            });
                            await Provider.of<UserProfile>(context,
                                    listen: false)
                                .getProfile(_mobileController.text);
                            setState(() {
                              _isInternet = true;
                            });
                            Navigator.of(context)
                                .pushReplacement(pageRouteBuilder('login'));
                          } on HttpException catch (_) {
                            Navigator.of(context)
                                .pushReplacement(pageRouteBuilder('signup'));
                          } catch (error) {
                            print(error.message);
                            if (error.message
                                .toString()
                                .contains('Failed host lookup')) {
                              setState(() {
                                _isLoading = false;
                                _isInternet = false;
                              });
                            }
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a mobile number';
                          }
                          if (value.length != 10) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                      child: _isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : const Text(
                              'Verify Phone Number',
                              style: TextStyle(
                                fontFamily: 'SourceSansProSB',
                                color: Colors.white,
                                fontSize: 15,
                              ),
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
                          setState(() {
                            _isInternet = true;
                          });
                          Navigator.of(context)
                              .pushReplacement(pageRouteBuilder('login'));
                        } on HttpException catch (_) {
                          Navigator.of(context)
                              .pushReplacement(pageRouteBuilder('signup'));
                        } catch (error) {
                          print(error.message);
                          if (error.message
                              .toString()
                              .contains('Failed host lookup')) {
                            setState(() {
                              _isLoading = false;
                              _isInternet = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          : NoInternetScreen(retry),
    );
  }

  PageRouteBuilder pageRouteBuilder(String text) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return OtpScreen(text);
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
}
