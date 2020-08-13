import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';
import '../providers/bikes.dart';
import '../screens/custom_repairs_detail_screen.dart';
import '../screens/new_bike_screen.dart';

class CustomRepairsItem extends StatefulWidget {
  final String type;
  final double price;
  final String image;

  CustomRepairsItem({this.price, this.type, this.image});

  @override
  CustomRepairsItemState createState() => CustomRepairsItemState();
}

class CustomRepairsItemState extends State<CustomRepairsItem> {
  var swap;
  var item;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    var cart = Provider.of<Cart>(context, listen: false);
    if (_isInit) {
      if (cart.findByType(widget.type) != -1) {
        item = CartItem(
          id: cart.getId(cart.findByType(widget.type)),
          price: widget.price,
          service: 'Custom Repairs',
          type: widget.type,
        );
      } else {
        item = CartItem(
          id: DateTime.now().toString(),
          price: widget.price,
          service: 'Custom Repairs',
          type: widget.type,
        );
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  PageRouteBuilder customRepairsDetailPageRoute(CartItem cart) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return CustomRepairsDetailScreen(cart);
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
                '+ Add Bike',
                style: TextStyle(
                  fontFamily: 'SourceSansProSB',
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).push(addBikePageRoute());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
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
            fit: BoxFit.cover,
          ),
          header: GridTileBar(
            backgroundColor: Color.fromRGBO(220, 220, 220, 0.9),
            title: Center(
              child: Text(
                widget.type,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SourceSansPro',
                  color: Color.fromRGBO(112, 112, 112, 1),
                  fontWeight: FontWeight.w500,
                ),
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
                    _showPopup('No bike selected', 'Please select a bike');
                  }
                },
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(customRepairsDetailPageRoute(item));
        },
      ),
    );
  }
}
