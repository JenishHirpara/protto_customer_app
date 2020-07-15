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
    if (order.status == '1') {
      return 'Service Confirmed';
    } else if (order.status == '2' || order.status == '3') {
      return 'Picked Up';
    } else if (order.status == '4') {
      return 'Dropped at station';
    } else if (order.status == '5') {
      return 'Service Started';
    } else if (order.status == '6' ||
        order.status == '7' ||
        order.status == '8') {
      return 'Service done';
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
            height: order.landmark != '' ? 225 : 205,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  offset: Offset(0.0, 5.0), //(x,y)
                  blurRadius: 7.0,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${order.make}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${order.model}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                            SizedBox(width: 8),
                            Text(
                              order.bookingId,
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
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
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Color.fromRGBO(128, 128, 128, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
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
                        SizedBox(height: 4),
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
                            SizedBox(width: 8),
                            Text(
                              order.time,
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
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
                                  ),
                                ),
                                TextSpan(
                                  text: order.landmark == ''
                                      ? '${order.flat}, ${order.address}'
                                      : '${order.flat},${order.landmark}, ${order.address}',
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
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
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 55,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Color.fromRGBO(112, 112, 112, 1),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Status:',
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Color.fromRGBO(128, 128, 128, 1),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            _getStatus(order),
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
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
