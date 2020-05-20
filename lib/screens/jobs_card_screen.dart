import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../providers/orders.dart';
import './shopping_cart_screen.dart';
import '../providers/cart_item.dart';
import '../utils/job_item.dart';

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
        builder: (BuildContext dialogcontext) {
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
                            Navigator.of(dialogcontext).pop();
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
                            Navigator.of(dialogcontext).pop();
                            Navigator.of(context)
                                .push(shoppingCartRouteBuilder());
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
        builder: (BuildContext dialogcontext) {
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
                            Navigator.of(dialogcontext).pop();
                            Navigator.of(context)
                                .push(shoppingCartRouteBuilder());
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
                            Navigator.of(context).pop();
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

  PageRouteBuilder shoppingCartRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ShoppingCartScreen();
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
    final cart = Provider.of<Cart>(context);
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: cart.items[i],
                  child: JobItem(),
                ),
                itemCount: cart.items.length,
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
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
