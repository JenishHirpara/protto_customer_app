import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import './support_screen.dart';
import './dashboard_screen.dart';
import './saved_addresses_screen.dart';
import './edit_profile_screen.dart';
import '../providers/profile.dart';
import '../providers/address.dart';
import '../providers/bikes.dart';
import '../providers/cart_item.dart';
import '../providers/orders.dart';
import './my_bikes_screen.dart';
import './verify_phone_screen.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var _isLoading = false;

  PageRouteBuilder supportPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SupportScreen();
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

  PageRouteBuilder verifyPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return VerifyPhoneScreen();
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

  PageRouteBuilder pageRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return DashBoardScreen();
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

  PageRouteBuilder savedAddressesRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SavedAddressesScreen();
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

  PageRouteBuilder editProfileRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return EditProfileScreen();
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

  PageRouteBuilder myBikesRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return MyBikesScreen();
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

  Future<void> _logout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you wish to logout?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _isLoading = true;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => VerifyPhoneScreen(),
                  ),
                );
                Provider.of<UserProfile>(context, listen: false).logout();
                Provider.of<Bikes>(context, listen: false).logout();
                Provider.of<Addresses>(context, listen: false).logout();
                Provider.of<Orders>(context, listen: false).logout();
                Provider.of<Cart>(context, listen: false).logout();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context).item;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).primaryColor,
            fontSize: 22,
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
      body: _isLoading
          ? Center(
              child: Image.asset(
                'assets/images/loader.gif',
                fit: BoxFit.cover,
                height: 85,
                width: 85,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${userProfile.name}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          userProfile.number,
                          style: TextStyle(
                            //fontFamily: 'Montserrat',
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          userProfile.email,
                          style: TextStyle(
                            //fontFamily: 'Montserrat',
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 0,
                              bottom: 0,
                              right: 16,
                              top: 0,
                            ),
                            leading: Container(
                              height: 75,
                              width: 50,
                              color: new Color(0xffffacaf),
                              child: Icon(
                                MdiIcons.accountEdit,
                                color: Color(0xffff7075),
                                size: 40,
                              ),
                            ),
                            title: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(editProfileRouteBuilder());
                        },
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 0,
                              bottom: 0,
                              right: 16,
                              top: 0,
                            ),
                            leading: Container(
                              height: 75,
                              width: 50,
                              color: new Color(0xffffacaf),
                              child: Icon(
                                Icons.location_on,
                                color: Color(0xffff7075),
                                size: 40,
                              ),
                            ),
                            title: Text(
                              'Saved Addresses',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(savedAddressesRouteBuilder());
                        },
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 0,
                              bottom: 0,
                              right: 16,
                              top: 0,
                            ),
                            leading: Container(
                              height: 75,
                              width: 50,
                              color: new Color(0xffffacaf),
                              child: Icon(
                                MdiIcons.heartOutline,
                                color: Color(0xffff7075),
                                size: 40,
                              ),
                            ),
                            title: Text(
                              'My Bikes',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(myBikesRouteBuilder());
                        },
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 0,
                              bottom: 0,
                              right: 16,
                              top: 0,
                            ),
                            leading: Container(
                              height: 75,
                              width: 50,
                              color: new Color(0xffffacaf),
                              child: Icon(
                                MdiIcons.cardAccountDetails,
                                color: Color(0xffff7075),
                                size: 40,
                              ),
                            ),
                            title: Text(
                              'Support',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(supportPageRoute());
                        },
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 0,
                              bottom: 0,
                              right: 16,
                              top: 0,
                            ),
                            leading: Container(
                              height: 75,
                              width: 50,
                              color: new Color(0xffffacaf),
                              child: Icon(
                                MdiIcons.logout,
                                color: Color(0xffff7075),
                                size: 40,
                              ),
                            ),
                            title: Text(
                              'Log Out',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ),
                        ),
                        onTap: () => _logout(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
