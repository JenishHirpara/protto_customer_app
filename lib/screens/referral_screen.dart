import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ReferralScreen extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Referral',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(24),
            child: Text(
              'Description of using the referral code',
              style: GoogleFonts.montserrat(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Text(
              '(Copy link or press share button)',
              style: GoogleFonts.montserrat(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Your Referral Code',
              style: GoogleFonts.montserrat(),
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
                'PROTTO001',
                style: GoogleFonts.cantataOne(
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
            child: RaisedButton(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Text(
                      'Share',
                      style: GoogleFonts.cantataOne(color: Colors.white),
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
              color: Colors.deepOrange,
              onPressed: () {
                Share.share('Referral Code: PROTTO001',
                    subject: 'Referral Code for Protto');
              },
            ),
          ),
        ],
      ),
    );
  }
}
