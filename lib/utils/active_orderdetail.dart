import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class ActiveOrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<ActiveOrderItem>(context);
    return Container(
      width: double.infinity,
      height: 160,
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
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.motorcycle,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      order.name,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Booking ID:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      order.id,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text(
                      'Pickup Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yy').format(order.date),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text(
                      'Pickup Time:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      order.time,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text(
                      'Pickup Address:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        order.address,
                        style: TextStyle(color: Colors.grey),
                        softWrap: true,
                      ),
                    ),
                  ],
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
                  onPressed: () {},
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
