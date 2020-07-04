import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protto_customer_app/utils/SizeConfig.dart';

Color orangeColor = new Color(0xfff15d24);

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Support',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(241, 93, 36, 1),
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
                              color: Colors.black),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Where will my bike be serviced?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Your bike will be serviced at Protto partnered service station. Protto partnered service station is selected based on reputation, turnaround time of service, quality of service delivered, and availability of genuine spares.',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'How long does it take to service a motorcycle?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'The service time for your motorcycle depends on the service package you opt for. A ProDRY service package takes 4-5 hours whereas, a ProWET service package takes at least 5-6 hours.',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Can I reschedule my booking appointment?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'You can reschedule your booking by visiting My Bookings in the Protto App.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'What if my bike needs extra services or part replacements?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'We will send you the request for additional jobs and associated costs. Upon your approval only, we will execute additional services.',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'I was charged for service which I didn’t opt for. What do I do?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Kindly contact us on email or call. Upon verifying the claim we will make the refund the amount immediately. For more queries on Refund check out our Service Revision & Refund Policy.',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'What Oil will be used during Bike Service?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'The oil used will be Motul Premium Mineral Engine Oil. The Oil Grades will be based on the type of Bike. The Grading system that we follow is based on the Society of Automotive Engineers (SAE). For Mopeds, we use SAE 10W 30 graded oil. SAE 20W 40 is used for major bikes ranging from 150 to 250 cc and SAE 15W 50 is used for engines will displacement of more than 250 cc.',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'What spare parts do you use during the service?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'We use 100% Genuine OEM/OES Spares. All the parts are pre-approved by our Team to ensure whatever goes into your motorcycle is nothing but a quality genuine spare part.',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Do I have to drop my two-wheeler at the service station?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Not at all, we provide FREE doorstep collection & delivery to save you from the hassle of visiting service station.',
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'How does Protto ensure safety against Coronavirus for my Two-wheeler?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'At Protto, health & hygiene are of utmost importance. As a part of the safety measure against novel Coronavirus we have started sanitizing all the bikes before collection & before delivery to ensure utmost safety of the two-wheeler owner community. We would request you to maintain social distancing at the time of bike collection & delivery for your utmost safety.',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro', fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: FlatButton(
                              onPressed: () {},
                              color: orangeColor,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'CALL',
                                      style: TextStyle(
                                          fontFamily: 'SourcsSansProSB',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: FlatButton(
                              onPressed: () {},
                              color: orangeColor,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'CHAT',
                                      style: TextStyle(
                                          fontFamily: 'SourceSansProSB',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
