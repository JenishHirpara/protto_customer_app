import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../utils/active_orderdetail.dart';
import '../utils/past_orderdetail.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activeorders = Provider.of<ActiveOrders>(context).items;
    final pastorders = Provider.of<PastOrders>(context).items;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            //height: 200,
            width: double.infinity,
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '  Active',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 160,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: activeorders[i],
                      child: ActiveOrderDetail(),
                    ),
                    itemCount: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            //height: 375,
            width: double.infinity,
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '  Past Bookings',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 350,
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => Column(
                      children: <Widget>[
                        ChangeNotifierProvider.value(
                          value: pastorders[i],
                          child: PastOrderDetail(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    itemCount: pastorders.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
