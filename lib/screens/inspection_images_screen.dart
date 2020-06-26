import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';

class InspectionImagesScreen extends StatefulWidget {
  final OrderItem order;

  InspectionImagesScreen(this.order);

  @override
  _InspectionImagesScreenState createState() => _InspectionImagesScreenState();
}

class _InspectionImagesScreenState extends State<InspectionImagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Inspection Images',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.order.make} ${widget.order.model}',
                    style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(241, 93, 36, 1),
                      fontSize: 20,
                    ),
                  ),
                  Text('2017'),
                  Text(widget.order.bikeNumber),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                'Pre Service Inspection',
                style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(112, 112, 112, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 10),
              height: 230,
              width: double.infinity,
              child: GridView(
                children: <Widget>[
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                ],
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Color.fromRGBO(240, 240, 240, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Odometer:',
                    style: GoogleFonts.cantataOne(
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '12,500',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Color.fromRGBO(240, 240, 240, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fuel Level:',
                    style: GoogleFonts.cantataOne(
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '75%',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            /////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                'Pre Delivery Inspection',
                style: GoogleFonts.montserrat(
                  color: Color.fromRGBO(112, 112, 112, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 10),
              height: 230,
              width: double.infinity,
              child: GridView(
                children: <Widget>[
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                ],
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Color.fromRGBO(240, 240, 240, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Odometer:',
                    style: GoogleFonts.cantataOne(
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '12,500',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Color.fromRGBO(240, 240, 240, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fuel Level:',
                    style: GoogleFonts.cantataOne(
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '75%',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
