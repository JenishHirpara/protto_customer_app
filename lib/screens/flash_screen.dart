import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

import '../providers/profile.dart';

class FlashScreen extends StatelessWidget {
  // Future _share(BuildContext originalcontext) {
  //   return showDialog(
  //     context: originalcontext,
  //     builder: (context) => Dialog(
  //       child: Container(
  //         height: 220,
  //         width: double.infinity,
  //         child: Column(
  //           children: <Widget>[
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: IconButton(
  //                 icon: Icon(Icons.clear),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 Column(
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Icon(Icons.message),
  //                       onPressed: () => Share.share(
  //                           'check out my website https://example.com'),
  //                       color: Colors.grey,
  //                     ),
  //                     Text(
  //                       'Message',
  //                       style: TextStyle(
  //                         color: Color.fromRGBO(112, 112, 112, 1),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Icon(Icons.email),
  //                       onPressed: _createEmail,
  //                       color: Colors.grey,
  //                     ),
  //                     Text(
  //                       'Email',
  //                       style: TextStyle(
  //                         color: Color.fromRGBO(112, 112, 112, 1),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: new Icon(MdiIcons.whatsapp),
  //                       onPressed: _launchWhatsApp,
  //                       color: Colors.grey,
  //                     ),
  //                     Text(
  //                       'Whatsapp',
  //                       style: TextStyle(
  //                         color: Color.fromRGBO(112, 112, 112, 1),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 5),
  //             Divider(
  //               color: Colors.grey,
  //               thickness: 1,
  //               indent: 25,
  //               endIndent: 25,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 Column(
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Icon(MdiIcons.facebookMessenger),
  //                       onPressed: _launchMessenger,
  //                       color: Colors.grey,
  //                     ),
  //                     Text(
  //                       'Messenger',
  //                       style: TextStyle(
  //                         color: Color.fromRGBO(112, 112, 112, 1),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Icon(MdiIcons.instagram),
  //                       onPressed: () {},
  //                       color: Colors.grey,
  //                     ),
  //                     Text(
  //                       'Instagram',
  //                       style: TextStyle(
  //                         color: Color.fromRGBO(112, 112, 112, 1),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Container(width: MediaQuery.of(context).size.width * 0.15),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void _createEmail() async {
  //   const emailaddress = 'mailto:?subject=Referral Code&body=PROTTO001';

  //   if (await canLaunch(emailaddress)) {
  //     await launch(emailaddress);
  //   } else {
  //     throw 'Could not Email';
  //   }
  // }

  // void _sendSMS() async {
  //   const phonenumber = "sms:";

  //   if (await canLaunch(phonenumber)) {
  //     await launch(phonenumber);
  //   } else {
  //     throw 'Could not SMS';
  //   }
  // }

  // void _launchWhatsApp() async {
  //   String phoneNumber = '+919833183245';
  //   String message = 'Referral Code: PROTTO001';
  //   var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
  //   if (await canLaunch(whatsappUrl)) {
  //     await launch(whatsappUrl);
  //   } else {
  //     throw 'Could not launch $whatsappUrl';
  //   }
  // }

  // void _launchMessenger() async {
  //   String messengerUrl = 'm.me/jenish.hirpara';
  //   // String message = 'Referral Code: PROTTO001';
  //   // var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
  //   if (await canLaunch("http://$messengerUrl")) {
  //     await launch("http://$messengerUrl");
  //     ;
  //   } else {
  //     throw 'Could not launch ';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final prottoBucks = Provider.of<UserProfile>(context).item.prottoBucks;
    final referal = Provider.of<UserProfile>(context).item.number;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(50, 50, 50, 1),
                    Theme.of(context).primaryColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: 220,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      'assets/images/protto-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Protto Bucks',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '₹ ' + prottoBucks,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Refer your Friends & Earn',
              style: TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'More Friends you bring in to use Protto, more you earn. Your friend gets Rs. 100 on Sign Up, you get Rs. 100 once your friend completes a booking with Protto',
              style: TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 75),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Your Referral Code',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color.fromRGBO(112, 112, 112, 1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(200, 200, 200, 1),
              ),
            ),
            child: ListTile(
              title: Text(
                referal,
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  color: Color.fromRGBO(128, 128, 128, 1),
                ),
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.content_copy,
                  color: Color.fromRGBO(128, 128, 128, 1),
                ),
                onTap: () {
                  Clipboard.setData(new ClipboardData(text: 'PROTTO001'));
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Text copied!',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: RaisedButton(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Text(
                      'Share',
                      style: TextStyle(
                        fontFamily: 'SourceSansProSB',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Share.share(
                    'Download this Awesome Bike Service App. Sign up with my referral code $referal & get Flat ₹100 OFF on First Booking. http://bit.ly/protto-app',
                    subject: 'Referral Code for Protto');
              },
            ),
          ),
        ],
      ),
    );
  }
}
