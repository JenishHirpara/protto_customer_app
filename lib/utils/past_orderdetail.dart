import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';

class PastOrderDetail extends StatelessWidget {
  final int i;
  PastOrderDetail(this.i);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context).pastOrders[i];
    return Container(
      width: double.infinity,
      height: 140,
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
                  child: Text(
                    '${order.make} ${order.model}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(241, 93, 36, 1),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
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
                SizedBox(height: 4),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Status:',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(128, 128, 128, 1),
                      ),
                    ),
                    Text(
                      'Delivered',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
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
