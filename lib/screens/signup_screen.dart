import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';
import '../models/http_exception.dart';
import './navigationBarScreen.dart';
import './no_internet_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();
  final _focus1 = FocusNode();
  final _focus2 = FocusNode();
  final _focus3 = FocusNode();
  final _focus4 = FocusNode();
  var _name = '';
  var _email = '';
  var _number = '';
  var _referal = '';
  var _isLoading = false;
  var _isInternet = true;

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

  void retry() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<UserProfile>(context, listen: false)
          .newProfile(_name, _email, _number, _referal);
      await Provider.of<UserProfile>(context, listen: false).setProfile();
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
      Navigator.of(context).pushReplacement(pageRouteBuilder());
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
      return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: TextStyle(fontFamily: 'SourceSansProSB'),
                ),
              ),
            ],
            title: Text(
              'An error occurred!',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            content: Text(
              error.message,
              style: TextStyle(fontFamily: 'SourceSansPro'),
            ),
          );
        },
      );
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

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_number == _referal) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Referal Error!',
                style: TextStyle(fontFamily: 'Montserrat')),
            content: Text(
              'You cant refer yourself, please refer someone else.',
              style: TextStyle(fontFamily: 'SourceSansPro'),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: TextStyle(fontFamily: 'SourceSansProSB'),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<UserProfile>(context, listen: false)
          .newProfile(_name, _email, _number, _referal);
      await Provider.of<UserProfile>(context, listen: false).setProfile();
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
      Navigator.of(context).pushReplacement(pageRouteBuilder());
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
      return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay',
                    style: TextStyle(fontFamily: 'SourceSansProSB')),
              ),
            ],
            title: Text(
              'An error occurred!',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            content: Text(
              error.message,
              style: TextStyle(fontFamily: 'SourceSansPro'),
            ),
          );
        },
      );
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
    final mobile = Provider.of<UserProfile>(context, listen: false).number;
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
                        (mediaQuery.size.height - mediaQuery.padding.top) * 0.2,
                  ),
                  Form(
                    key: _form,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle:
                                    TextStyle(fontFamily: 'SourceSansPro')),
                            textInputAction: TextInputAction.next,
                            focusNode: _focus1,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focus2);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide a name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = value;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            initialValue: mobile,
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: 'Mobile No.',
                                labelStyle:
                                    TextStyle(fontFamily: 'SourceSansPro')),
                            textInputAction: TextInputAction.next,
                            focusNode: _focus2,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focus3);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide a mobile no.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _number = value;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    TextStyle(fontFamily: 'SourceSansPro')),
                            textInputAction: TextInputAction.next,
                            focusNode: _focus3,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focus4);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide an email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Referal code',
                              labelStyle:
                                  TextStyle(fontFamily: 'SourceSansPro'),
                            ),
                            textInputAction: TextInputAction.done,
                            focusNode: _focus4,
                            onFieldSubmitted: (_) => _saveForm(),
                            onSaved: (value) {
                              _referal = value;
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
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
                          child: RaisedButton(
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontFamily: 'SourceSansProSB',
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                            onPressed: _saveForm,
                            color: Theme.of(context).primaryColor,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : NoInternetScreen(retry),
    );
  }
}
