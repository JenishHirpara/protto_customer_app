import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class ActiveOrderScreen extends StatefulWidget {
  final ActiveOrderItem order;

  ActiveOrderScreen(this.order);

  @override
  _ActiveOrderScreenState createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  int bottomNavBarIndex = 0;

  Future showPopUp() {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: double.infinity,
          height: 175,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Text(
                      'OTP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<SampleStepTile> get steps {
    return [
      SampleStepTile(
        title: Text(
          'Service Confirmed',
          textAlign: TextAlign.left,
          style: GoogleFonts.cantataOne(),
        ),
        date: widget.order.date,
        time: widget.order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Bike Picked Up',
              style: GoogleFonts.cantataOne(),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'OTP',
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                onPressed: showPopUp,
              ),
            ),
          ],
        ),
        date: widget.order.date,
        time: widget.order.time,
      ),
      SampleStepTile(
        title: Text(
          'Bike Dropped at Service Station',
          textAlign: TextAlign.left,
          style: GoogleFonts.cantataOne(),
        ),
        date: widget.order.date,
        time: widget.order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pre Service Inspection',
              textAlign: TextAlign.left,
              style: GoogleFonts.cantataOne(),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'View Images',
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        date: widget.order.date,
        time: widget.order.time,
      ),
      SampleStepTile(
        title: Text(
          'Service Started',
          textAlign: TextAlign.left,
          style: GoogleFonts.cantataOne(),
        ),
        date: widget.order.date,
        time: widget.order.time,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Active Order',
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
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.motorcycle,
                    size: 50,
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.order.name,
                        style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(241, 93, 36, 1),
                          fontSize: 20,
                        ),
                      ),
                      Text('2017'),
                      Text(widget.order.number),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: 40,
                    child: RaisedButton(
                      child: Text(
                        'Jobs',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Track the progress',
              style: GoogleFonts.montserrat(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 520,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: steps.map((step) {
                  return Container(
                    height: 110,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 110,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      DateFormat('dd/MM').format(step.date),
                                      style: GoogleFonts.cantataOne(
                                        color: Color.fromRGBO(128, 128, 128, 1),
                                      ),
                                    ),
                                    Text(
                                      step.time,
                                      style: GoogleFonts.cantataOne(
                                        color: Color.fromRGBO(128, 128, 128, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.radio_button_checked,
                                      color: Theme.of(context).primaryColor,
                                      size: 20,
                                    ),
                                    Container(
                                      height: 90,
                                      child: VerticalDivider(
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 110,
                                child: step.title,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 60),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SampleStepTile {
  SampleStepTile({
    Key key,
    this.title,
    this.date,
    this.time,
  });

  Widget title;
  DateTime date;
  String time;
}
