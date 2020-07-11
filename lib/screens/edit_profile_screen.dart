import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/SizeConfig.dart';
import '../providers/profile.dart';

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
  var newProfile;

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

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<UserProfile>(context, listen: false).editProfile(newProfile);
    Navigator.of(context).pop();
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
      body: SingleChildScrollView(
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                    ),
                    focusNode: _focusNode2,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_focusNode3),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide Email ID';
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                    ),
                    focusNode: _focusNode3,
                    onFieldSubmitted: (_) => _saveForm(),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide Phone Number';
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
                    child: FlatButton(
                      color: orangeColor,
                      onPressed: _saveForm,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
