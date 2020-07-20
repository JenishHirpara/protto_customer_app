import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class PastOrderDetail extends StatelessWidget {
  final int i;
  PastOrderDetail(this.i);

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
            height: 140,
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
                            color: Theme.of(context).primaryColor,
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
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(112, 112, 112, 1),
                        size: 20,
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
          ),
        ),
      ),
    );
  }
}
