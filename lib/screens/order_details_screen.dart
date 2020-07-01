import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../utils/active_orderdetail.dart';
import '../utils/past_orderdetail.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final activeorders = Provider.of<Orders>(context).activeOrders;
    final pastorders = Provider.of<Orders>(context).pastOrders;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
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
          );
  }
}
