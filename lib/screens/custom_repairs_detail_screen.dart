import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/SizeConfig.dart';
import '../providers/cart_item.dart';
import '../providers/bikes.dart';
import 'support_screen.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> insuranceClaim = [
  'Claim Guidance',
  'Complete Bike Inspection',
];

List<String> brakeInspection = [
  'Brake Assembly Inspection',
  'Brake Fluid Top-up',
  'Brake Bleeding',
];

List<String> clutchInspection = [
  'Clutch Assembly Inspection',
  'Clutch Play Adjustment',
];

List<String> electricalInspection = [
  'Wiring Harness inspection',
  'Wiring Routing',
];

List<String> other = [
  'Engine Heating Up?',
  'Body vibrating',
];

String text = 'Part replacements & additional repairs cost not included';

Color backGroundColor = new Color(0xffE9E9E9);

class CustomRepairsDetailScreen extends StatefulWidget {
  final CartItem cartitem;
  CustomRepairsDetailScreen(this.cartitem);

  @override
  CustomRepairsDetailScreenState createState() =>
      CustomRepairsDetailScreenState();
}

class CustomRepairsDetailScreenState extends State<CustomRepairsDetailScreen> {
  List<String> details = [];
  var _isInit = true;

  PageRouteBuilder supportScreenPageRoute() {
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

  void _launchWhatsApp(String phoneNumber) async {
    String message = '';
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      switch (widget.cartitem.type) {
        case 'Insurance Claim':
          details = insuranceClaim;
          break;
        case 'Brake Inspection':
          details = brakeInspection;
          break;
        case 'Electrical Inspection':
          details = electricalInspection;
          break;
        case 'Clutch Inspection':
          details = clutchInspection;
          break;
        case 'Other':
          details = other;
          break;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
        title: Text(
          widget.cartitem.type,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 85,
              color: backGroundColor,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
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
                          '3 Hours',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
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
                        border: Border.all(color: Colors.white, width: 0.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, i) => Column(
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
                                      details[i],
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color(0xff707070),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            itemCount: details.length,
                          )),
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
                          color: Colors.blueGrey,
                        ),
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
                            onPressed: () {
                              Navigator.of(context)
                                  .push(supportScreenPageRoute());
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      color: Colors.blueGrey,
                                    ),
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
                            onPressed: () => _launchWhatsApp('+919136231963'),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      color: Colors.blueGrey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (Provider.of<Cart>(context, listen: false)
                                    .findByType(widget.cartitem.type) ==
                                -1 &&
                            Provider.of<Bikes>(context, listen: false)
                                    .activeBike !=
                                null) {
                          Provider.of<Cart>(context, listen: false)
                              .addItem(widget.cartitem);
                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added item to cart!',
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                ),
                              ),
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  Provider.of<Cart>(context, listen: false)
                                      .deleteItem(widget.cartitem.id);
                                },
                              ),
                            ),
                          );
                        } else if (Provider.of<Bikes>(context, listen: false)
                                .activeBike ==
                            null) {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text(
                                  'No bike selected',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
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
                                'Item cannot be added',
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: Text(
                              'Add To Cart',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
