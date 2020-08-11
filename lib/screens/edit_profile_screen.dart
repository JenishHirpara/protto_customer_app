import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/SizeConfig.dart';
import '../providers/profile.dart';
import './otp_screen.dart';
import '../models/http_exception.dart';
import './no_internet_screen.dart';

Color orangeColor = new Color(0xfff15d24);

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _form = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  var _isInit = true;
  var _isLoading = false;
  var _isInternet = true;
  var newProfile;

  void retry() async {
    _saveForm();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      newProfile = Profile(
        id: DateTime.now().toString(),
        name: '',
        email: '',
        number: '',
        prottoBucks:
            Provider.of<UserProfile>(context, listen: false).item.prottoBucks,
        otp: Provider.of<UserProfile>(context, listen: false).item.otp,
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  PageRouteBuilder otpRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return OtpScreen('edit');
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

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<UserProfile>(context, listen: false)
          .getOtp(newProfile.name, newProfile.number, newProfile.email);
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
      Navigator.of(context).pushReplacement(otpRouteBuilder());
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Duplicate User'),
          content: Text(
            error.message,
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
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
    final oldProfile = Provider.of<UserProfile>(context).item;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: _isInternet
          ? SingleChildScrollView(
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 80,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Form(
                    key: _form,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          initialValue: oldProfile.name,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                          ),
                          focusNode: _focusNode1,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_focusNode2),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide Name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            newProfile = Profile(
                              id: newProfile.id,
                              name: value,
                              number: newProfile.number,
                              email: newProfile.email,
                              prottoBucks: newProfile.prottoBucks,
                              otp: newProfile.otp,
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: oldProfile.email,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                          ),
                          focusNode: _focusNode2,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_focusNode3),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide an email';
                            }
                            RegExp regExp = new RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (!regExp.hasMatch(value)) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            newProfile = Profile(
                              id: newProfile.id,
                              name: newProfile.name,
                              number: newProfile.number,
                              email: value,
                              prottoBucks: newProfile.prottoBucks,
                              otp: newProfile.otp,
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: oldProfile.number,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          focusNode: _focusNode3,
                          onFieldSubmitted: (_) => _saveForm(),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide Phone Number';
                            }
                            if (value.length != 10) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            newProfile = Profile(
                              id: newProfile.id,
                              name: newProfile.name,
                              number: value,
                              email: newProfile.email,
                              prottoBucks: newProfile.prottoBucks,
                              otp: newProfile.otp,
                            );
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: 40,
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
                          child: FlatButton(
                            color: orangeColor,
                            onPressed: _saveForm,
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Text(
                                    'Save',
                                    style: TextStyle(
                                      fontFamily: 'SourceSansProSB',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : NoInternetScreen(retry),
    );
  }
}
