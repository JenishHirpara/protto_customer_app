import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/SizeConfig.dart';
import '../providers/cart_item.dart';
import '../providers/bikes.dart';

String one = 'Engine Oil Replacement';
String two = 'Electrical Inspection';
String three = 'Battery Charging';
String four = 'Brake Inspection & Service';
String five = 'Control Inspection & Lubrication';
String six = 'Spark Plug Check & Clean';
String seven = 'Air Filter Check & Clean';
String eight = 'Carburettor/Injector Inspection & clean';
String nine = 'Suspension Inspection & Service';
String ten = 'Fastener Inspection & Tightening';
String eleven = 'Bearing Inspection & Lubrication';
String twelve = 'Stand Inspection & Lubrication';
String thirteen = 'Chain Lubrication & Tightening';
String fourteen = 'Foam Wash';

String text = 'Part replacements & additional repairs cost not included';

Color backGroundColor = new Color(0xffE9E9E9);

class ProwetDetailsScreen extends StatefulWidget {
  final CartItem cartitem;
  ProwetDetailsScreen(this.cartitem);

  @override
  _ProwetDetailsScreenState createState() => _ProwetDetailsScreenState();
}

class _ProwetDetailsScreenState extends State<ProwetDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: backGroundColor,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
          onTap: () {
            Navigator.of(context).pop(true);
          },
        ),
        title: Image(
          image: AssetImage('assets/images/ProWet.png'),
          width: 150,
          height: 50,
        ),
      ),
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        color: backGroundColor,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.history,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '5 Hours',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.autorenew,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Every 4000 KMs or 3 Months',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                              border:
                                  Border.all(color: Colors.white, width: 0.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      one,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      two,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      three,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      four,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      five,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      six,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      seven,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      eight,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      nine,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      ten,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      eleven,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      twelve,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      thirteen,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      fourteen,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            text,
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              color: Theme.of(context).primaryColor,
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {},
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.help,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'FAQs',
                                        style: TextStyle(
                                            fontFamily: 'SourceSansProSB',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Theme.of(context).primaryColor,
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {},
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.chat_bubble,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Chat',
                                        style: TextStyle(
                                            fontFamily: 'SourceSansProSB',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 1,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            color: new Color(0xffF15D24),
                            onPressed: () {
                              if (Provider.of<Cart>(context, listen: false)
                                          .findByType('PROWET') ==
                                      -1 &&
                                  Provider.of<Bikes>(context, listen: false)
                                          .activeBike !=
                                      null) {
                                Provider.of<Cart>(context, listen: false)
                                    .addItem(widget.cartitem);

                                Scaffold.of(context).hideCurrentSnackBar();
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added item to cart!',
                                        style: TextStyle(
                                          fontFamily: 'SourceSansPro',
                                        )),
                                    duration: Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: 'UNDO',
                                      onPressed: () {
                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .deleteItem(widget.cartitem.id);
                                      },
                                    ),
                                  ),
                                );
                              } else if (Provider.of<Bikes>(context,
                                          listen: false)
                                      .activeBike ==
                                  null) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text('No bike selected',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                          )),
                                      content: Text('Please select a bike',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                          )),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            'Okay',
                                            style: TextStyle(
                                              fontFamily: 'SourceSansProSB',
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                Scaffold.of(context).hideCurrentSnackBar();
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Item already added',
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                      ),
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Text(
                                    '₹ ${widget.cartitem.price}',
                                    style: TextStyle(
                                        fontFamily: 'SourceSansProSB',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                  child: Text(
                                    ' ADD TO CART',
                                    style: TextStyle(
                                      fontFamily: 'SourceSansProSB',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
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
