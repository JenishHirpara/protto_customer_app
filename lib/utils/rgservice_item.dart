import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';
import '../screens/service_details_screen.dart';

class RgServiceItem extends StatefulWidget {
  final String type;
  final double price;

  RgServiceItem({this.price, this.type});

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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    if (cart.findByType(widget.type) != -1) {
      swap = true;
    } else {
      swap = false;
    }
    return InkWell(
      child: GridTile(
        child: Container(),
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.type,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '₹ ${widget.price.toString()}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        footer: Container(
          color: Color.fromRGBO(200, 200, 200, 1),
          height: 75,
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
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'ADD',
                          style: TextStyle(color: Colors.white),
                        ),
                ],
              ),
              color: swap ? Colors.green : Colors.deepOrange,
              onPressed: () {
                if (cart.findByType(widget.type) == -1) {
                  setState(() {
                    swap = !swap;
                  });
                  cart.addItem(item);
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