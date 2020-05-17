import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';

class JobsCardScreen extends StatefulWidget {
  final ActiveOrderItem order;

  JobsCardScreen(this.order);

  @override
  _JobsCardScreenState createState() => _JobsCardScreenState();
}

class _JobsCardScreenState extends State<JobsCardScreen> {
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  bool checkedValue5 = false;

  int bottomNavBarIndex = 0;

  String alertDialogText = "You have approved all of your \n" +
      "additional services. Your new total is ";

  String alertDialogTwo = "You did not approve all the services \n" +
      "suggested in the job card. Are you sure \n" +
      "you still want to move forward without \n" +
      "those services? ";

  Future<dynamic> approveAllAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 5,
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: RichText(
                      text: TextSpan(
                          text: alertDialogText,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          children: <TextSpan>[
                            TextSpan(
                                text: "₹ 3198",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                          ]),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.deepOrange),
                          ),
                          onPressed: () {
                            // TODO Jobs button OnPressed...
                            Navigator.of(context).pop(true);
                          },
                          elevation: 5,
                          child: Text(
                            'Jobs',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        RaisedButton(
                          elevation: 5,
                          color: Colors.deepOrange,
                          child: Text('Checkout',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                          onPressed: () {
                            // TODO Approve Selected OnPressed...
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> approveSelectedAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 5,
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: 400,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: RichText(
                      text: TextSpan(
                        text: alertDialogTwo,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.deepOrange),
                          ),
                          onPressed: () {
                            // TODO Jobs button OnPressed...
//                            Navigator.of(context)
//                                .pop(true);
                          },
                          elevation: 5,
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.deepOrange),
                          ),
                          onPressed: () {
                            // TODO Jobs button OnPressed...
                            Navigator.of(context).pop(true);
                          },
                          elevation: 5,
                          child: Text(
                            'No',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.order.name,
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 3.0,
              color: Color.fromRGBO(241, 93, 36, 1),
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: bottomNavBarIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          iconSize: 30,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.event_note),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.flash_on),
              title: Text(''),
            )
          ],
          onTap: (int newIndex) {
            setState(() {
              bottomNavBarIndex = newIndex;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Pre - Booked Services',
                style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(112, 112, 112, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Container(
                width: double.infinity,
                height: 140,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'PRODRY',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      subtitle: Text(
                        'Regular Service',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Text(
                          '₹ 1599',
                          style: GoogleFonts.cantataOne(
                            color: Color.fromRGBO(128, 128, 128, 1),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Tyre 1',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      subtitle: Text(
                        'Tyre',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Text(
                          '₹ 1599',
                          style: GoogleFonts.cantataOne(
                            color: Color.fromRGBO(128, 128, 128, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Additional Services',
                style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(112, 112, 112, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Container(
                width: double.infinity,
                height: 275,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Job Number 1',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '₹ 1599',
                              style: GoogleFonts.cantataOne(
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                            Checkbox(
                                value: checkedValue1,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkedValue1 = newValue;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Job Number 2',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '₹ 1599',
                              style: GoogleFonts.cantataOne(
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                            Checkbox(
                                value: checkedValue2,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkedValue2 = newValue;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Job Number 3',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '₹ 1599',
                              style: GoogleFonts.cantataOne(
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                            Checkbox(
                                value: checkedValue3,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkedValue3 = newValue;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Job Number 4',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '₹ 1599',
                              style: GoogleFonts.cantataOne(
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                            Checkbox(
                                value: checkedValue4,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkedValue4 = newValue;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Job Number 5',
                        style: GoogleFonts.cantataOne(
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Row(
                          children: <Widget>[
                            Text(
                              '₹ 1599',
                              style: GoogleFonts.cantataOne(
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                            Checkbox(
                                value: checkedValue5,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkedValue5 = newValue;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'Item Total',
                  style: GoogleFonts.cantataOne(),
                ),
                trailing: Text(
                  '₹ 3198',
                  style: GoogleFonts.cantataOne(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  color: Theme.of(context).primaryColor,
                  height: 40,
                  width: double.infinity,
                  child: RaisedButton(
                    color: new Color(0xffF15D24),
                    onPressed: () {
                      // TODO Approve All OnPressed ...
                      approveAllAlertDialog(context);
                    },
                    child: Text(
                      'Approve All',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.deepOrange),
                        ),
                        elevation: 0,
                        child: Text(
                          'Approve Selected',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        onPressed: () {
                          approveSelectedAlertDialog(context);
                        },
                      ),
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          side: BorderSide(color: Colors.deepOrange),
                        ),
                        elevation: 0,
                        child: Text(
                          'Contact Support',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        onPressed: () {
                          // TODO Approve Selected OnPressed...
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
