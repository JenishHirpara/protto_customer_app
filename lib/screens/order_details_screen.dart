import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../utils/active_orderdetail.dart';
import '../utils/past_orderdetail.dart';
import './no_internet_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var _isInit = true;
  var _isLoading;
  var _isInternet = true;

  void retry() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      Provider.of<Orders>(context, listen: false).endLoad();
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
    } catch (error) {
      print(error.message);
      if (error.message.toString().contains('Failed host lookup')) {
        Provider.of<Orders>(context, listen: false).endLoad();
        setState(() {
          _isInternet = false;
        });
      }
    }
  }

  @override
  void didChangeDependencies() async {
    _isLoading = Provider.of<Orders>(context, listen: false).loadOrders;
    if (_isInit) {
      try {
        if (_isLoading) {
          await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
          Provider.of<Orders>(context, listen: false).endLoad();
          setState(() {
            _isInternet = true;
          });
        }
      } catch (error) {
        print(error.message);
        if (error.message.toString().contains('Failed host lookup')) {
          Provider.of<Orders>(context, listen: false).endLoad();
          setState(() {
            _isInternet = false;
          });
        }
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final activeorders = Provider.of<Orders>(context).activeOrders;
    final pastorders = Provider.of<Orders>(context).pastOrders;
    return _isLoading
        ? Center(
            child: Image.asset(
              'assets/images/loader.gif',
              fit: BoxFit.cover,
              height: 85,
              width: 85,
            ),
          )
        : _isInternet
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                    pastorders.isEmpty
                        ? Container()
                        : Container(
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
              )
            : NoInternetScreen(retry);
  }
}
