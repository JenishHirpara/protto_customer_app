import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';
import '../providers/bikes.dart';
import '../screens/prodry_details_screen.dart';
import '../screens/prowet_details_screen.dart';

class RgServiceItem extends StatefulWidget {
  final String type;
  final double price;
  final String image;

  RgServiceItem({this.price, this.type, this.image});

  @override
  _RgServiceItemState createState() => _RgServiceItemState();
}

class _RgServiceItemState extends State<RgServiceItem> {
  var swap;
  var item;

  @override
  void initState() {
    item = CartItem(
      id: DateTime.now().toString(),
      price: widget.price,
      service: 'Regular Service',
      type: widget.type,
    );
    super.initState();
  }

  PageRouteBuilder proDryDetailsPageRoute(CartItem cart) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ProdryDetailsScreen(cart);
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

  PageRouteBuilder proWetDetailsPageRoute(CartItem cart) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ProwetDetailsScreen(cart);
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

  Future<void> _showPopup(String title, String content) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          content: Text(
            content,
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Okay',
                style: TextStyle(fontFamily: 'SourceSansProSB'),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final activebike = Provider.of<Bikes>(context, listen: false).activeBike;
    if (cart.findByType(widget.type) != -1) {
      swap = true;
    } else {
      swap = false;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        child: GridTile(
          child: Image.asset(
            widget.image,
            fit: BoxFit.none,
            scale: 3,
            // fit: BoxFit.cover,
          ),
          header: GridTileBar(
            backgroundColor: Color.fromRGBO(220, 220, 220, 0.9),
            title: Center(
              child: Image(
                image: widget.type == 'PRODRY'
                    ? AssetImage('assets/images/ProDry.png')
                    : AssetImage('assets/images/ProWet.png'),
                width: 100,
                height: 30,
              ),
            ),
            subtitle: Center(
              child: Text(
                '₹ ${widget.price.toString()}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          // header: Container(
          //   color: Color.fromRGBO(230, 230, 230, 0.4),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       Text(
          //         widget.type,
          //         style: TextStyle(
          //           fontFamily: 'Montserrat',
          //           fontSize: 18,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       SizedBox(height: 10),
          //       Text(
          //         '₹ ${widget.price.toString()}',
          //         style: TextStyle(
          //           fontFamily: 'Montserrat',
          //           fontSize: 16,
          //           color: Colors.deepOrange,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          footer: Container(
            color: Color.fromRGBO(230, 230, 230, 1),
            height: 85,
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Center(
              heightFactor: 0.5,
              widthFactor: 0.5,
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    swap
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                    swap
                        ? Text(
                            'Added',
                            style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Add',
                            style: TextStyle(
                                fontFamily: 'SourceSansProSB',
                                color: Colors.white),
                          ),
                  ],
                ),
                color: swap ? Colors.green : Theme.of(context).primaryColor,
                onPressed: () {
                  if (activebike != null) {
                    if (cart.findByType('PRODRY') == -1 &&
                        cart.findByType('PROWET') == -1) {
                      setState(() {
                        swap = !swap;
                      });
                      cart.addItem(item);
                    } else {
                      setState(() {
                        swap = !swap;
                        cart.removeItem(item);
                      });
                    }
                  } else {
                    _showPopup('No bike selected', 'Please select a bike');
                  }
                },
              ),
            ),
          ),
        ),
        onTap: () {
          if (widget.type == 'PRODRY') {
            Navigator.of(context).push(proDryDetailsPageRoute(item));
          } else if (widget.type == 'PROWET') {
            Navigator.of(context).push(proWetDetailsPageRoute(item));
          }
        },
      ),
    );
  }
}
