import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../utils/user_profile_item.dart';
import './support_screen.dart';
import './referral_screen.dart';
import './dashboard_screen.dart';
import './saved_addresses_screen.dart';
import './edit_profile_screen.dart';
import '../providers/profile.dart';

class UserProfileScreen extends StatelessWidget {
  PageRouteBuilder supportPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SupportScreen();
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

  PageRouteBuilder referralPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ReferralScreen();
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

  PageRouteBuilder pageRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return DashBoardScreen();
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

  PageRouteBuilder savedAddressesRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SavedAddressesScreen();
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

  PageRouteBuilder editProfileRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return EditProfileScreen();
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

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context).item;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                    '${userProfile.firstName} ${userProfile.lastName}',
                    style: GoogleFonts.montserrat(fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userProfile.number,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userProfile.email,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              children: <Widget>[
                UserProfileItem(
                  icon: Icon(MdiIcons.fileEdit),
                  title: 'Edit Profile',
                  page: editProfileRouteBuilder(),
                ),
                SizedBox(height: 20),
                UserProfileItem(
                  icon: Icon(MdiIcons.locationEnter),
                  title: 'Saved Addresses',
                  page: savedAddressesRouteBuilder(),
                ),
                SizedBox(height: 20),
                UserProfileItem(
                  icon: Icon(MdiIcons.heart),
                  title: 'My Garage',
                  page: pageRouteBuilder(),
                ),
                SizedBox(height: 20),
                UserProfileItem(
                  icon: Icon(MdiIcons.history),
                  title: 'Order History',
                  page: pageRouteBuilder(),
                ),
                SizedBox(height: 20),
                UserProfileItem(
                  icon: Icon(MdiIcons.fileDocument),
                  title: 'My Docs',
                  page: pageRouteBuilder(),
                ),
                SizedBox(height: 20),
                UserProfileItem(
                  icon: Icon(MdiIcons.cardAccountDetails),
                  title: 'Support',
                  page: supportPageRoute(),
                ),
                SizedBox(height: 20),
                UserProfileItem(
                  icon: Icon(MdiIcons.bell),
                  title: 'Referral',
                  page: referralPageRoute(),
                ),
                SizedBox(height: 20),
                UserProfileItem(
                  icon: Icon(MdiIcons.logout),
                  title: 'Log Out',
                  page: pageRouteBuilder(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
