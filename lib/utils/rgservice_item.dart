import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';
import '../providers/bikes.dart';
import '../screens/service_details_screen.dart';

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

  PageRouteBuilder serviceDetailsPageRoute(CartItem cart) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ServiceDetailsScreen(cart);
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

  Future<void> _showPopup() {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'No bike selected',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          content: Text(
            'Please select a bike',
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
    return InkWell(
      child: GridTile(
        child: Image.asset(
          widget.image,
          fit: BoxFit.none,
          scale: 3,
          // fit: BoxFit.cover,
        ),
        header: GridTileBar(
          backgroundColor: Color.fromRGBO(230, 230, 230, 0.6),
          title: Text(
            widget.type,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '₹ ${widget.price.toString()}',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: Colors.deepOrange,
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
          padding: EdgeInsets.symmetric(horizontal: 30),
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
                        )
                      : Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                  swap
                      ? Text(
                          'ADDED',
                          style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              color: Colors.white),
                        )
                      : Text(
                          'ADD',
                          style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              color: Colors.white),
                        ),
                ],
              ),
              color: swap ? Colors.green : Colors.deepOrange,
              onPressed: () {
                if (activebike != null) {
                  if (cart.findByType(widget.type) == -1) {
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
                  _showPopup();
                }
              },
            ),
          ),
        ),
      ),
      onTap: () {
        if (widget.type == 'PRODRY') {
          Navigator.of(context).push(serviceDetailsPageRoute(item));
        }
      },
    );
  }
}
