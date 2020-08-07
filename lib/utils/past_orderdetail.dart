import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class PastOrderDetail extends StatelessWidget {
  final int i;
  PastOrderDetail(this.i);

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
    final order = Provider.of<Orders>(context).pastOrders[i];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            //height: 140,
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
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                SizedBox(height: 3),
                Row(
                  children: <Widget>[
                    Text(
                      'Service Date:',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(order.date)),
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
