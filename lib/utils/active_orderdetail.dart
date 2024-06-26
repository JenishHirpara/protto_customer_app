import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';
import '../screens/active_order_screen.dart';

class ActiveOrderDetail extends StatelessWidget {
  final int i;
  ActiveOrderDetail(this.i);

  // ------------------- PageRoute ------------//
  PageRouteBuilder pageRouteBuilder(order) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ActiveOrderScreen(order);
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

  String _getStatus(OrderItem order) {
    if (order.status == '1' || order.status == '2') {
      return 'Service Confirmed';
    } else if (order.status == '3') {
      return 'Picked Up';
    } else if (order.status == '4') {
      return 'Dropped at station';
    } else if (order.status == '5') {
      return 'Service Started';
    } else if (order.status == '6') {
      return 'Service done';
    } else if (order.status == '7' || order.status == '8') {
      return 'Picked from station';
    } else if (order.status == '9') {
      return 'Delivered';
    } else {
      return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context).activeOrders[i];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(pageRouteBuilder(order));
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            //height: order.landmark != '' ? 260 : 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0.0, 5.0), //(x,y)
                  blurRadius: 7.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        bottom: 0,
                        top: 16,
                        right: 0,
                      ),
                      child: Text(
                        '${order.make}',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Theme.of(context).primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 55,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Active',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '${order.model}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Status:',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            _getStatus(order),
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: <Widget>[
                          Text(
                            'Booking ID:',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            order.bookingId,
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: <Widget>[
                          Text(
                            'Pickup Date:',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            DateFormat('dd/MM/yy')
                                .format(DateTime.parse(order.date)),
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: <Widget>[
                          Text(
                            'Pickup Time:',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            order.time,
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Pickup Address: ',
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  color: Color.fromRGBO(128, 128, 128, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: order.landmark == ''
                                    ? '${order.flat}, ${order.address}'
                                    : '${order.flat},${order.landmark}, ${order.address}',
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
