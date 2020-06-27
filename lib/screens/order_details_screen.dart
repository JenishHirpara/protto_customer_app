import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';
import '../utils/active_orderdetail.dart';
import '../utils/past_orderdetail.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final activeorders = Provider.of<Orders>(context).activeOrders;
    final pastorders = Provider.of<Orders>(context).pastOrders;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Details',
          style: TextStyle(
            fontFamily: 'Montserrat',
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
                      fontFamily: 'Montserrat',
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
                      fontFamily: 'Montserrat',
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
                          child: PastOrderDetail(i),
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
