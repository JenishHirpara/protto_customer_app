import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';
import '../screens/active_order_screen.dart';

class ActiveOrderDetail extends StatelessWidget {
  final int i;
  ActiveOrderDetail(this.i);

  Future showPopup(context) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          height: 210,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Icon(
                        Icons.motorcycle,
                        size: 75,
                        color: Color.fromRGBO(150, 150, 150, 1),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 110,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'My Bike',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromRGBO(100, 100, 100, 1),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('MH 02 KG 0904'),
                          SizedBox(height: 10),
                          Container(
                            width: 150,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              ),
                            ),
                            child: RaisedButton(
                              color: Colors.white,
                              child: Text('Manage'),
                              elevation: 0,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                endIndent: 10,
                indent: 10,
                thickness: 1,
                height: 0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: FlatButton(
                    child: Text(
                      '+ Add New Bike',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------- PageRoute ------------//
  PageRouteBuilder pageRouteBuilder(order) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ActiveOrderScreen(order);
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
    final order = Provider.of<ActiveOrders>(context).items[i];
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepOrange,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => showPopup(context),
                    child: Text(
                      order.name,
                      style: GoogleFonts.montserrat(
                        color: Color.fromRGBO(241, 93, 36, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Booking ID:',
                      style: GoogleFonts.cantataOne(
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      order.id,
                      style: GoogleFonts.cantataOne(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text(
                      'Pickup Date:',
                      style: GoogleFonts.cantataOne(
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yy').format(order.date),
                      style: GoogleFonts.cantataOne(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text(
                      'Pickup Time:',
                      style: GoogleFonts.cantataOne(
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      order.time,
                      style: GoogleFonts.cantataOne(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'PickupAddress: ',
                          style: GoogleFonts.cantataOne(
                            color: Color.fromRGBO(128, 128, 128, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: order.address,
                          style: GoogleFonts.cantataOne(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.of(context).push(pageRouteBuilder(order));
                  },
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Status:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      order.status,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
