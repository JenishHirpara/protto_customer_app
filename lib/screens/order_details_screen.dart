import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';
import '../utils/active_orderdetail.dart';
import '../utils/past_orderdetail.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activeorders = Provider.of<ActiveOrders>(context).items;
    final pastorders = Provider.of<PastOrders>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: GoogleFonts.montserrat(
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Container(),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) => Column(
                        children: <Widget>[
                          ChangeNotifierProvider.value(
                            value: activeorders[i],
                            child: ActiveOrderDetail(i),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      itemCount: activeorders.length,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
