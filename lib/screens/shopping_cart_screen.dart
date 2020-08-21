import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:protto_customer_app/providers/profile.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/shopping_cart_item.dart';
import '../providers/cart_item.dart';
import '../providers/address.dart';
import './select_address_screen.dart';
import './add_address_screen.dart';
import '../providers/orders.dart';
import '../providers/bikes.dart';
import './active_order_screen.dart';
import '../models/http_exception.dart';
import './no_internet_screen.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  Address _addressSeen;
  var _date;
  var _prottoBucks;
  var minCartValue;
  var percentDiscount;
  var maxDiscount;
  var couponDiscount;
  var paymentId = "";
  final _form = GlobalKey<FormState>();
  var _textController = TextEditingController();
  var _isLoading = false;
  var _isInternet = true;

  Future selectAddress(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SelectAddressScreen(_addressSeen),
    );
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      _isLoading = true;
    });
    var city = Provider.of<UserProfile>(context, listen: false).city;
    var _id = await Provider.of<Orders>(context, listen: false).addOrder(
      _orderItem,
      _prottoBucks,
      Provider.of<Bikes>(context, listen: false).activeBike,
      _orderItem.total,
      response.paymentId,
      city,
    );
    setState(() {
      _isLoading = false;
    });
    Provider.of<Cart>(context, listen: false).resetCart();
    var _order = Provider.of<Orders>(context, listen: false).findById(_id);
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Color.fromRGBO(253, 253, 253, 1),
          child: Container(
            height: 285,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  height: 75,
                  width: 75,
                  padding: EdgeInsets.all(0),
                  child: Image.asset('assets/images/tick.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'ORDER CONFIRMED',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'Thanks for using Protto. Your order has been successfully placed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 14,
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(pageRouteBuilder(_order));
                    },
                    elevation: 2,
                    child: Text(
                      'Track Progress',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void handlerErrorFailure(PaymentFailureResponse response) {}

  void handlerExternalWallet(ExternalWalletResponse response) async {
    setState(() {
      _isLoading = true;
    });
    var city = Provider.of<UserProfile>(context, listen: false).city;
    var _id = await Provider.of<Orders>(context, listen: false).addOrder(
      _orderItem,
      _prottoBucks,
      Provider.of<Bikes>(context, listen: false).activeBike,
      _orderItem.total,
      response.walletName,
      city,
    );
    setState(() {
      _isLoading = false;
    });
    Provider.of<Cart>(context, listen: false).resetCart();
    var _order = Provider.of<Orders>(context, listen: false).findById(_id);
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Color.fromRGBO(253, 253, 253, 1),
          child: Container(
            height: 285,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  height: 75,
                  width: 75,
                  padding: EdgeInsets.all(0),
                  child: Image.asset('assets/images/tick.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'ORDER CONFIRMED',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'Thanks for using Protto. Your order has been successfully placed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 14,
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(pageRouteBuilder(_order));
                    },
                    elevation: 2,
                    child: Text(
                      'Track Progress',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _razorPay(Cart cart) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_orderItem.date == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'No date added',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            content: Text(
              'Please add a date to your current order.',
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Okay',
                  style: TextStyle(fontFamily: 'SourceSansProSB'),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (_orderItem.serviceType == '') {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'No service added',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            content: Text(
              'Please add atleast one service to your current order.',
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Okay',
                  style: TextStyle(fontFamily: 'SourceSansProSB'),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      var profile = Provider.of<UserProfile>(context, listen: false).item;
      _orderItem = OrderItem(
        id: _orderItem.id,
        bookingId: _orderItem.bookingId,
        address: _addressSeen.address,
        bikeid: Provider.of<Bikes>(context, listen: false).activeBike.id,
        bikeNumber:
            Provider.of<Bikes>(context, listen: false).activeBike.number,
        bikeYear: Provider.of<Bikes>(context, listen: false).activeBike.year,
        addressId: _addressSeen.id,
        flat: _addressSeen.flat,
        landmark: _addressSeen.landmark,
        total: _orderItem.total,
        paid: _orderItem.paid,
        ssName: _orderItem.ssName,
        deId: _orderItem.deId,
        make: Provider.of<Bikes>(context, listen: false).activeBike.brand,
        model: Provider.of<Bikes>(context, listen: false).activeBike.model,
        status: _orderItem.status,
        specialRequest: _orderItem.specialRequest,
        approveJobs: _orderItem.approveJobs,
        rideable: _orderItem.rideable,
        serviceType: _orderItem.serviceType,
        date: _orderItem.date,
        time: _orderItem.time,
        deliveryType: _orderItem.deliveryType,
      );
      final storage = new FlutterSecureStorage();
      String username = await storage.read(key: 'username');
      var options = {
        'key': username,
        'amount': double.parse(_getNewTotal(cart)) * 100,
        'name': 'Protto',
        'description': _orderItem.serviceType,
        'prefill': {'contact': profile.number, 'email': profile.email},
        'external': {
          'wallets': ['paytm']
        }
      };
      try {
        await _razorpay.open(options);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  PageRouteBuilder addAddressScreenPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AddAddressScreen();
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

  var _orderItem;
  var _razorpay;

  @override
  void initState() {
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    final cart = Provider.of<Cart>(context, listen: false).items;
    var services = '';
    for (int i = 0; i < cart.length; i++) {
      services = services + '${cart[i].type}(${cart[i].service}),';
    }
    _orderItem = OrderItem(
      id: null,
      bookingId: null,
      address: _addressSeen == null ? null : _addressSeen.address,
      bikeid: '',
      bikeNumber: '',
      bikeYear: '',
      addressId: _addressSeen == null ? null : _addressSeen.id,
      flat: _addressSeen == null ? null : _addressSeen.flat,
      landmark: _addressSeen == null ? null : _addressSeen.landmark,
      approveJobs: '0',
      make: '',
      model: '',
      status: '1',
      rideable: '',
      specialRequest: '',
      total: _getNewTotal(Provider.of<Cart>(context, listen: false)),
      paid: '',
      serviceType: services,
      ssName: null,
      deId: null,
      date: null,
      deliveryType: 'Pick & Drop',
      time: '',
    );
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _presentDatePicker() {
    var nextYear;
    var nextmonth;
    if (DateTime.now().month == 12) {
      nextmonth = 1;
      nextYear = DateTime.now().year + 1;
    } else {
      nextmonth = DateTime.now().month + 1;
      nextYear = DateTime.now().year;
    }
    var day = DateTime.now().day;
    var date;
    if (DateTime.now().hour >= 15) {
      date = DateTime.now().add(Duration(days: 1));
    } else {
      date = DateTime.now();
    }
    showDatePicker(
      context: context,
      initialDate: _date == null
          ? date
          : DateTime(int.parse(_date.split('-')[0]),
              int.parse(_date.split('-')[1]), int.parse(_date.split('-')[2])),
      firstDate: date,
      lastDate: DateTime(nextYear, nextmonth, day),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      var chosenDate = pickedDate.toString().split(' ')[0];
      setState(() {
        _date = chosenDate;
      });
      _orderItem = OrderItem(
        id: _orderItem.id,
        bookingId: _orderItem.bookingId,
        address: _orderItem.address,
        bikeid: _orderItem.bikeid,
        bikeNumber: _orderItem.bikeNumber,
        bikeYear: _orderItem.bikeYear,
        addressId: _orderItem.addressId,
        flat: _orderItem.flat,
        landmark: _orderItem.landmark,
        total: _orderItem.total,
        paid: _orderItem.paid,
        make: _orderItem.make,
        model: _orderItem.model,
        status: _orderItem.status,
        specialRequest: _orderItem.specialRequest,
        approveJobs: _orderItem.approveJobs,
        rideable: _orderItem.rideable,
        ssName: _orderItem.ssName,
        deId: _orderItem.deId,
        serviceType: _orderItem.serviceType,
        date: chosenDate,
        time: _orderItem.time,
        deliveryType: _orderItem.deliveryType,
      );
    });
  }

  List<String> _getTime() {
    if (_date == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      if (DateTime.now().hour >= 15 || DateTime.now().hour < 9) {
        return ['9 AM - 11 AM', '11 AM - 1 PM', '1 PM - 3 PM', '3 PM - 5 PM'];
      } else if (DateTime.now().hour >= 9 && DateTime.now().hour < 11) {
        return ['11 AM - 1 PM', '1 PM - 3 PM', '3 PM - 5 PM'];
      } else if (DateTime.now().hour >= 11 && DateTime.now().hour < 13) {
        return ['1 PM - 3 PM', '3 PM - 5 PM'];
      } else {
        return ['3 PM - 5 PM'];
      }
    } else {
      return ['9 AM - 11 AM', '11 AM - 1 PM', '1 PM - 3 PM', '3 PM - 5 PM'];
    }
  }

  void _saveForm(Cart cart) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_orderItem.date == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'No date added',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            content: Text(
              'Please add a date to your current order',
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Okay',
                  style: TextStyle(fontFamily: 'SourceSansProSB'),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (_orderItem.serviceType == '') {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'No service added',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            content: Text(
              'Please add atleast one service to your current order',
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Okay',
                  style: TextStyle(fontFamily: 'SourceSansProSB'),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      _orderItem = OrderItem(
        id: _orderItem.id,
        bookingId: _orderItem.bookingId,
        address: _addressSeen.address,
        bikeid: Provider.of<Bikes>(context, listen: false).activeBike.id,
        bikeNumber:
            Provider.of<Bikes>(context, listen: false).activeBike.number,
        bikeYear: Provider.of<Bikes>(context, listen: false).activeBike.year,
        addressId: _addressSeen.id,
        flat: _addressSeen.flat,
        landmark: _addressSeen.landmark,
        total: _getNewTotal(cart),
        paid: _orderItem.paid,
        ssName: _orderItem.ssName,
        deId: _orderItem.deId,
        make: Provider.of<Bikes>(context, listen: false).activeBike.brand,
        model: Provider.of<Bikes>(context, listen: false).activeBike.model,
        status: _orderItem.status,
        specialRequest: _orderItem.specialRequest,
        approveJobs: _orderItem.approveJobs,
        rideable: _orderItem.rideable,
        serviceType: _orderItem.serviceType,
        date: _orderItem.date,
        time: _orderItem.time,
        deliveryType: _orderItem.deliveryType,
      );
      setState(() {
        _isLoading = true;
      });
      try {
        var city = Provider.of<UserProfile>(context, listen: false).city;
        var _id = await Provider.of<Orders>(context, listen: false).addOrder(
          _orderItem,
          _prottoBucks,
          Provider.of<Bikes>(context, listen: false).activeBike,
          '0.0',
          paymentId,
          city,
        );
        setState(() {
          _isLoading = false;
        });
        Provider.of<Cart>(context, listen: false).resetCart();
        var _order = Provider.of<Orders>(context, listen: false).findById(_id);
        showDialog(
          context: context,
          builder: (ctx) {
            return Dialog(
              backgroundColor: Color.fromRGBO(253, 253, 253, 1),
              child: Container(
                height: 285,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      height: 75,
                      width: 75,
                      padding: EdgeInsets.all(0),
                      child: Image.asset('assets/images/tick.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'ORDER CONFIRMED',
                      style: TextStyle(
                        fontFamily: 'SourceSansProSB',
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        'Thanks for using Protto. Your order has been successfully placed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 14,
                          color: Color.fromRGBO(112, 112, 112, 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), //(x,y)
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(pageRouteBuilder(_order));
                        },
                        elevation: 2,
                        child: Text(
                          'Track Progress',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } catch (error) {
        print(error.message);
        if (error.message.toString().contains('Failed host lookup')) {
          setState(() {
            _isLoading = false;
          });
          showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                child: Container(
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(0),
                        child: Image.asset('assets/images/cancel.png'),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'ORDER FAILURE',
                        style: TextStyle(
                          fontFamily: 'SourceSansProSB',
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'Looks like something went wrong while processing your request. Please try again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 14,
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400],
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0), //(x,y)
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          elevation: 2,
                          child: Text(
                            'Okay',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }
    }
  }

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

  String _getDiscount(Cart cart) {
    if (couponDiscount == null) {
      var prottoBucks = double.parse(
          Provider.of<UserProfile>(context, listen: false).item.prottoBucks);
      var totalBefore = cart.getTotal();
      if (totalBefore >= prottoBucks) {
        _prottoBucks = 0.0;
        return prottoBucks.toString();
      } else {
        _prottoBucks = prottoBucks - totalBefore;
        return totalBefore.toString();
      }
    } else {
      var totalBefore = cart.getTotal();
      if (totalBefore >= minCartValue) {
        if (totalBefore >= couponDiscount) {
          return couponDiscount.toString();
        } else {
          return totalBefore.toString();
        }
      } else {
        var prottoBucks = double.parse(
            Provider.of<UserProfile>(context, listen: false).item.prottoBucks);
        var totalBefore = cart.getTotal();
        if (totalBefore >= prottoBucks) {
          _prottoBucks = 0.0;
          return prottoBucks.toString();
        } else {
          _prottoBucks = prottoBucks - totalBefore;
          return totalBefore.toString();
        }
      }
    }
  }

  void retry() {
    setState(() {});
  }

  void couponDialog(Cart cart) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Coupon code activated.',
            style: TextStyle(
              color: Color.fromRGBO(128, 128, 128, 1),
              fontFamily: 'SourceSansProSB',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  String _getNewTotal(Cart cart) {
    var totalBefore = cart.getTotal();
    return '${(totalBefore - double.parse(_getDiscount(cart)))}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: _isLoading
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) =>
                            ChangeNotifierProvider.value(
                          value: cart.items[i],
                          child: ShoppingCartItem(),
                        ),
                        itemCount: cart.items.length,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Totals',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Item Total',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                          ),
                          trailing: Text(
                            '₹ ${cart.getTotal().toString()}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      _getDiscount(cart) == '0.0'
                          ? Container()
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                  'Discount',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                trailing: Text(
                                  '₹ ${_getDiscount(cart)}',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                      _getDiscount(cart) == '0.0'
                          ? Container()
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                  'New Total',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  '₹ ${_getNewTotal(cart)}',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          enabled: true,
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Enter Voucher Code',
                            hintStyle: TextStyle(fontFamily: 'SourceSansPro'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide(
                                color: _getDiscount(cart) == '0.0'
                                    ? Theme.of(context).primaryColor
                                    : Colors.green,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                              borderSide: BorderSide(
                                color: _getDiscount(cart) == '0.0'
                                    ? Theme.of(context).primaryColor
                                    : Colors.green,
                              ),
                            ),
                            suffixIcon: Container(
                              margin: EdgeInsets.symmetric(horizontal: 26),
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: InkWell(
                                child: Text(
                                  _getDiscount(cart) == '0.0'
                                      ? 'APPLY'
                                      : 'APPLIED',
                                  style: TextStyle(
                                    fontFamily: 'SourceSansProSB',
                                    color: _getDiscount(cart) == '0.0'
                                        ? Theme.of(context).primaryColor
                                        : Colors.green,
                                  ),
                                ),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  var coupon;
                                  try {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    coupon = await Provider.of<Orders>(context,
                                            listen: false)
                                        .couponcode(_textController.text);
                                    couponDialog(cart);
                                    minCartValue = double.parse(coupon[0]);
                                    percentDiscount = double.parse(coupon[1]);
                                    maxDiscount = double.parse(coupon[2]);
                                    setState(() {
                                      _isLoading = false;
                                      _isInternet = true;
                                    });
                                    if (maxDiscount != -1) {
                                      couponDiscount = maxDiscount;
                                    } else {
                                      couponDiscount = cart.getTotal() *
                                          percentDiscount /
                                          100;
                                    }
                                  } on HttpException catch (error) {
                                    setState(() {
                                      _isInternet = true;
                                      _isLoading = false;
                                    });
                                    minCartValue = null;
                                    maxDiscount = null;
                                    percentDiscount = null;
                                    couponDiscount = null;
                                    showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: Text(
                                            error.message,
                                            style: TextStyle(
                                              fontFamily: 'SourceSansProSB',
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text('Okay'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } catch (error) {
                                    print(error.message);
                                    if (error.message
                                        .toString()
                                        .contains('Failed host lookup')) {
                                      setState(() {
                                        _isInternet = false;
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      Form(
                        key: _form,
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Select Delivery Type',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButtonFormField(
                                value: 'Pick & Drop',
                                elevation: 1,
                                decoration: InputDecoration(
                                  focusColor: Color.fromRGBO(240, 240, 240, 1),
                                  fillColor: Color.fromRGBO(240, 240, 240, 1),
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: 'Delivery Type',
                                  hintStyle: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    color: Color.fromRGBO(128, 128, 128, 1),
                                    fontSize: 14,
                                  ),
                                ),
                                items: <String>['Pick & Drop', 'Self Delivery']
                                    .map<DropdownMenuItem>((value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please provide delivery type';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _orderItem = OrderItem(
                                    id: _orderItem.id,
                                    bookingId: _orderItem.bookingId,
                                    address: _orderItem.address,
                                    bikeid: _orderItem.bikeid,
                                    bikeNumber: _orderItem.bikeNumber,
                                    bikeYear: _orderItem.bikeYear,
                                    flat: _orderItem.flat,
                                    landmark: _orderItem.landmark,
                                    addressId: _orderItem.addressId,
                                    total: _orderItem.total,
                                    paid: _orderItem.paid,
                                    make: _orderItem.make,
                                    model: _orderItem.model,
                                    status: _orderItem.status,
                                    specialRequest: _orderItem.specialRequest,
                                    ssName: _orderItem.ssName,
                                    deId: _orderItem.deId,
                                    approveJobs: _orderItem.approveJobs,
                                    rideable: _orderItem.rideable,
                                    serviceType: _orderItem.serviceType,
                                    date: _orderItem.date,
                                    time: _orderItem.time,
                                    deliveryType: value,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Select Date and Time',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 45,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  // color: Color.fromRGBO(255, 255, 255, 1),
                                  //borderRadius: BorderRadius.circular(4.0),
                                  ),
                              child: RaisedButton(
                                color: Color.fromRGBO(240, 240, 240, 1),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: _date == null
                                      ? Text(
                                          'Date',
                                          style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                128, 128, 128, 1),
                                          ),
                                        )
                                      : Text(
                                          _date,
                                          style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                ),
                                elevation: 0,
                                onPressed: _presentDatePicker,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButtonFormField(
                                elevation: 1,
                                decoration: InputDecoration(
                                  fillColor: Color.fromRGBO(240, 240, 240, 1),
                                  focusColor: Color.fromRGBO(240, 240, 240, 1),
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: 'Time Slot',
                                  hintStyle: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    color: Color.fromRGBO(128, 128, 128, 1),
                                    fontSize: 14,
                                  ),
                                ),
                                items:
                                    _getTime().map<DropdownMenuItem>((value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please provide time slot';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _orderItem = OrderItem(
                                    id: _orderItem.id,
                                    bookingId: _orderItem.bookingId,
                                    address: _orderItem.address,
                                    bikeid: _orderItem.bikeid,
                                    bikeNumber: _orderItem.bikeNumber,
                                    bikeYear: _orderItem.bikeYear,
                                    addressId: _orderItem.addressId,
                                    flat: _orderItem.flat,
                                    landmark: _orderItem.landmark,
                                    total: _orderItem.total,
                                    paid: _orderItem.paid,
                                    ssName: _orderItem.ssName,
                                    deId: _orderItem.deId,
                                    make: _orderItem.make,
                                    model: _orderItem.model,
                                    status: _orderItem.status,
                                    specialRequest: _orderItem.specialRequest,
                                    approveJobs: _orderItem.approveJobs,
                                    rideable: _orderItem.rideable,
                                    serviceType: _orderItem.serviceType,
                                    date: _orderItem.date,
                                    time: value,
                                    deliveryType: _orderItem.deliveryType,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Any Special Request',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  fillColor: Color.fromRGBO(240, 240, 240, 1),
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: 'Any Special Request',
                                  hintStyle: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 14,
                                  ),
                                ),
                                onSaved: (value) {
                                  _orderItem = OrderItem(
                                    id: _orderItem.id,
                                    bookingId: _orderItem.bookingId,
                                    address: _orderItem.address,
                                    bikeid: _orderItem.bikeid,
                                    bikeNumber: _orderItem.bikeNumber,
                                    bikeYear: _orderItem.bikeYear,
                                    addressId: _orderItem.addressId,
                                    flat: _orderItem.flat,
                                    landmark: _orderItem.landmark,
                                    total: _orderItem.total,
                                    paid: _orderItem.paid,
                                    ssName: _orderItem.ssName,
                                    deId: _orderItem.deId,
                                    make: _orderItem.make,
                                    model: _orderItem.model,
                                    status: _orderItem.status,
                                    specialRequest: value,
                                    approveJobs: _orderItem.approveJobs,
                                    rideable: _orderItem.rideable,
                                    serviceType: _orderItem.serviceType,
                                    date: _orderItem.date,
                                    time: _orderItem.time,
                                    deliveryType: _orderItem.deliveryType,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Select Address',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Offstage(
                                offstage: _addressSeen == null,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    _addressSeen != null
                                        ? Container(
                                            width: double.infinity,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      _addressSeen.saveas,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Color.fromRGBO(
                                                            112, 112, 112, 1),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _addressSeen = null;
                                                        });
                                                      },
                                                      child: Text(
                                                        'Change Address',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'SourceSansPro',
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                _addressSeen.landmark != null
                                                    ? Text(
                                                        '${_addressSeen.flat}, ${_addressSeen.landmark}, ${_addressSeen.address}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'SourceSansPro',
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                        ),
                                                      )
                                                    : Text(
                                                        '${_addressSeen.flat}, ${_addressSeen.address}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'SourceSansPro',
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                        ),
                                                      )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                            //SizedBox(height: 10),
                            _addressSeen == null
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[400],
                                                spreadRadius: 0.0,
                                                offset:
                                                    Offset(2.0, 2.0), //(x,y)
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                          ),
                                          child: RaisedButton(
                                            color: Colors.white,
                                            child: Text(
                                              'Add Address',
                                              style: TextStyle(
                                                fontFamily: 'SourceSansProSB',
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
                                              ),
                                            ),
                                            elevation: 2,
                                            onPressed: () async {
                                              final result = await Navigator.of(
                                                      context)
                                                  .push(
                                                      addAddressScreenPageRoute());
                                              setState(() {
                                                if (result != null) {
                                                  _addressSeen = result;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[400],
                                                spreadRadius: 0.0,
                                                offset:
                                                    Offset(2.0, 2.0), //(x,y)
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                          ),
                                          child: RaisedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              'Select Address',
                                              style: TextStyle(
                                                  fontFamily: 'SourceSansProSB',
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              final result1 =
                                                  await selectAddress(context);
                                              setState(() {
                                                if (result1 != null) {
                                                  _addressSeen = result1;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 40,
                                          child: RaisedButton(
                                            color: Colors.white,
                                            child: Text(
                                              'Pay Later',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SourceSansProSB'),
                                            ),
                                            elevation: 2,
                                            onPressed: () => _saveForm(cart),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 40,
                                          child: RaisedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                  fontFamily: 'SourceSansProSB',
                                                  color: Colors.white),
                                            ),
                                            onPressed: () => _razorPay(cart),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : NoInternetScreen(retry),
    );
  }
}
