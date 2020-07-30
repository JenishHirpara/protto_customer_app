import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/SizeConfig.dart';

Color orangeColor = new Color(0xfff15d24);

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool expanded1 = false;
  bool expanded2 = false;
  bool expanded3 = false;
  bool expanded4 = false;
  bool expanded5 = false;
  bool expanded6 = false;
  bool expanded7 = false;
  bool expanded8 = false;
  bool expanded9 = false;

  void _launchWhatsApp(String phoneNumber) async {
    String message = '';
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  void _launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
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
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'FAQs',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Where will my bike be serviced?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded1
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded1 = true;
                            });
                          else
                            setState(() {
                              expanded1 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Your bike will be serviced at Protto partnered service station. Protto partnered service station is selected based on reputation, turnaround time of service, quality of service delivered, and availability of genuine spares.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'How long does it take to service a motorcycle?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded2
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded2 = true;
                            });
                          else
                            setState(() {
                              expanded2 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'The service time for your motorcycle depends on the service package you opt for. A ProDRY service package takes 4-5 hours whereas, a ProWET service package takes at least 5-6 hours.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Can I reschedule my booking appointment?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded3
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded3 = true;
                            });
                          else
                            setState(() {
                              expanded3 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'You can reschedule your booking by visiting My Bookings in the Protto App.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'What if my bike needs extra services or part replacements?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded4
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded4 = true;
                            });
                          else
                            setState(() {
                              expanded4 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'We will send you the request for additional jobs and associated costs. Upon your approval only, we will execute additional services.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'I was charged for service which I didn’t opt for. What do I do?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded5
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded5 = true;
                            });
                          else
                            setState(() {
                              expanded5 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Kindly contact us on email or call. Upon verifying the claim we will make the refund the amount immediately. For more queries on Refund check out our Service Revision & Refund Policy.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'What Oil will be used during Bike Service?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded6
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded6 = true;
                            });
                          else
                            setState(() {
                              expanded6 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'The oil used will be Motul Premium Mineral Engine Oil. The Oil Grades will be based on the type of Bike. The Grading system that we follow is based on the Society of Automotive Engineers (SAE). For Mopeds, we use SAE 10W 30 graded oil. SAE 20W 40 is used for major bikes ranging from 150 to 250 cc and SAE 15W 50 is used for engines will displacement of more than 250 cc.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'What spare parts do you use during the service?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded7
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded7 = true;
                            });
                          else
                            setState(() {
                              expanded7 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'We use 100% Genuine OEM/OES Spares. All the parts are pre-approved by our Team to ensure whatever goes into your motorcycle is nothing but a quality genuine spare part.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Do I have to drop my two-wheeler at the service station?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded8
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded8 = true;
                            });
                          else
                            setState(() {
                              expanded8 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Not at all, we provide FREE doorstep collection & delivery to save you from the hassle of visiting service station.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'How does Protto ensure safety against Coronavirus for my Two-wheeler?',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: expanded9
                                ? Theme.of(context).primaryColor
                                : Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              expanded9 = true;
                            });
                          else
                            setState(() {
                              expanded9 = false;
                            });
                        }),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'At Protto, health & hygiene are of utmost importance. As a part of the safety measure against novel Coronavirus we have started sanitizing all the bikes before collection & before delivery to ensure utmost safety of the two-wheeler owner community. We would request you to maintain social distancing at the time of bike collection & delivery for your utmost safety.',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: FlatButton(
                                      onPressed: () {
                                        return showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Call',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontFamily: 'Montserrat'),
                                                ),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        30, 0, 30, 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    8, 0, 8, 8),
                                                            child: Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    offset:
                                                                        Offset(
                                                                            2.0,
                                                                            2.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: FlatButton(
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed: () =>
                                                                      _launchCaller(
                                                                          'tel:+919136231963'),
                                                                  child: Text(
                                                                      'About New Booking ',
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              128,
                                                                              128,
                                                                              128,
                                                                              1),
                                                                          fontFamily:
                                                                              'SourceSansProSB'))),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    8,
                                                                    10,
                                                                    8,
                                                                    8),
                                                            child: Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    offset:
                                                                        Offset(
                                                                            2.0,
                                                                            2.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: FlatButton(
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed: () =>
                                                                      _launchCaller(
                                                                          'tel:+919136863480'),
                                                                  child: Text(
                                                                      'About Current Booking ',
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              128,
                                                                              128,
                                                                              128,
                                                                              1),
                                                                          fontFamily:
                                                                              'SourceSansProSB'))),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      color: orangeColor,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Call',
                                              style: TextStyle(
                                                fontFamily: 'SourcsSansProSB',
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: FlatButton(
                                      onPressed: () {
                                        return showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Chat',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontFamily: 'Montserrat'),
                                                ),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        30, 0, 30, 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    8, 0, 8, 8),
                                                            child: Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    offset:
                                                                        Offset(
                                                                            2.0,
                                                                            2.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: FlatButton(
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed: () =>
                                                                      _launchWhatsApp(
                                                                          '+919136231963'),
                                                                  child: Text(
                                                                      'About New Booking ',
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              128,
                                                                              128,
                                                                              128,
                                                                              1),
                                                                          fontFamily:
                                                                              'SourceSansProSB'))),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    8,
                                                                    10,
                                                                    8,
                                                                    8),
                                                            child: Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    offset:
                                                                        Offset(
                                                                            2.0,
                                                                            2.0),
                                                                    blurRadius:
                                                                        6.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: FlatButton(
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed: () =>
                                                                      _launchWhatsApp(
                                                                          '+919136863480'),
                                                                  child: Text(
                                                                      'About Current Booking ',
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              128,
                                                                              128,
                                                                              128,
                                                                              1),
                                                                          fontFamily:
                                                                              'SourceSansProSB'))),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      //=>_launchWhatsApp('+919136231963'),
                                      color: orangeColor,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.chat,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Chat',
                                              style: TextStyle(
                                                fontFamily: 'SourceSansProSB',
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
