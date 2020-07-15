import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/SizeConfig.dart';
import '../providers/cart_item.dart';
import '../providers/bikes.dart';
import 'support_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/new_bike_screen.dart';

List<String> proDry = [
  'Brake Inspection & Service',
  'Control Inspection & Lubrication',
  'Spark Plug Check & Clean',
  'Air Filter Check & Clean',
  'Carburettor/Injector Inspection & clean',
  'Suspension Inspection & Service',
  'Fastener Inspection & Tightening',
  'Bearing Inspection & Lubrication',
  'Stand Inspection & Lubrication',
  'Chain Lubrication & Tightening',
  'Foam Wash'
];

List<String> proWet = [
  'Engine Oil Replacement',
  'Electrical Inspection',
  'Battery Charging',
  'Brake Inspection & Service',
  'Control Inspection & Lubrication',
  'Spark Plug Check & Clean',
  'Air Filter Check & Clean',
  'Carburettor/Injector Inspection & clean',
  'Suspension Inspection & Service',
  'Fastener Inspection & Tightening',
  'Bearing Inspection & Lubrication',
  'Stand Inspection & Lubrication',
  'Chain Lubrication & Tightening',
  'Foam Wash',
];

String text = 'Part replacements & additional repairs cost not included';

Color backGroundColor = new Color(0xffE9E9E9);

class RgDetailsScreen extends StatefulWidget {
  final CartItem cartitem;
  RgDetailsScreen(this.cartitem);

  @override
  RgDetailsScreenState createState() => RgDetailsScreenState();
}

class RgDetailsScreenState extends State<RgDetailsScreen> {
  PageRouteBuilder supportScreenPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SupportScreen();
      },
      transitionDuration: Duration(milliseconds: 300),
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

  PageRouteBuilder addBikePageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NewBikeScreen();
      },
      transitionDuration: Duration(milliseconds: 300),
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
          image: widget.cartitem.type == 'PRODRY'
              ? AssetImage('assets/images/ProDry.png')
              : AssetImage('assets/images/ProWet.png'),
          width: 150,
          height: 50,
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
                          widget.cartitem.type == 'PRODRY'
                              ? '5 Hours'
                              : '7 Hours',
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
                          widget.cartitem.type == 'PRODRY'
                              ? 'Every 2500 KMs or 2 Months'
                              : 'Every 4000 KMs or 3 Months',
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
                        child: widget.cartitem.type == 'PRODRY'
                            ? ListView.builder(
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
                                          proDry[i],
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
                                itemCount: proDry.length,
                              )
                            : ListView.builder(
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
                                          proWet[i],
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
                                itemCount: proWet.length,
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
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (Provider.of<Cart>(context, listen: false)
                                    .findByType('PRODRY') ==
                                -1 &&
                            Provider.of<Cart>(context, listen: false)
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
                                      '+ Add Bike',
                                      style: TextStyle(
                                        fontFamily: 'SourceSansProSB',
                                        fontSize: 18,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.of(context)
                                          .push(addBikePageRoute());
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
