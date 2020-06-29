import 'package:flutter/material.dart';
import 'package:protto_customer_app/providers/profile.dart';
import 'package:provider/provider.dart';

import '../utils/shopping_cart_item.dart';
import '../providers/cart_item.dart';
import '../providers/address.dart';
import './select_address_screen.dart';
import './add_address_screen.dart';
import '../providers/orders.dart';
import '../providers/bikes.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  Address _addressSeen;
  var _date;
  var _prottoBucks;
  var _pressedOne = false;
  var _pressedTwo = false;
  final _form = GlobalKey<FormState>();

  Future selectAddress(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SelectAddressScreen(_addressSeen),
    );
  }

  PageRouteBuilder addAddressScreenPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AddAddressScreen();
      },
      transitionDuration: Duration(milliseconds: 500),
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
  @override
  void initState() {
    final cart = Provider.of<Cart>(context, listen: false).items;
    var services = '';
    for (int i = 0; i < cart.length; i++) {
      services = services + '${cart[i].type},';
    }
    _orderItem = OrderItem(
      id: null,
      bookingId: null,
      address: _addressSeen == null ? null : _addressSeen.address,
      bikeid: '',
      bikeNumber: '',
      bikeYear: '',
      flat: _addressSeen == null ? null : _addressSeen.flat,
      landmark: _addressSeen == null ? null : _addressSeen.landmark,
      make: '',
      model: '',
      status: '',
      rideable: '',
      serviceType: services,
      date: null,
      deliveryType: '',
      time: '',
    );
    super.initState();
  }

  void _presentDatePicker() {
    var nextYear = DateTime.now().year + 1;
    var month = DateTime.now().month;
    var day = DateTime.now().day;
    var date;
    if (DateTime.now().hour >= 15) {
      date = DateTime.now().add(Duration(days: 1));
    } else {
      date = DateTime.now();
    }
    showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: DateTime(nextYear, month, day),
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
        flat: _orderItem.flat,
        landmark: _orderItem.landmark,
        make: _orderItem.make,
        model: _orderItem.model,
        status: _orderItem.status,
        rideable: _orderItem.rideable,
        serviceType: _orderItem.serviceType,
        date: chosenDate,
        time: _orderItem.time,
        deliveryType: _orderItem.deliveryType,
      );
    });
  }

  List<String> _getTime() {
    if (DateTime.now().hour >= 15 || DateTime.now().hour < 9) {
      return ['9-11', '11-1', '1-3', '3-5'];
    } else if (DateTime.now().hour >= 9 && DateTime.now().hour < 11) {
      return ['11-1', '1-3', '3-5'];
    } else if (DateTime.now().hour >= 11 && DateTime.now().hour < 13) {
      return ['1-3', '3-5'];
    } else {
      return ['3-5'];
    }
  }

  void _saveForm() async {
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
              'Please add a date to your current order',
              style: TextStyle(fontFamily: 'SourceSansPro'),
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
              'Please add atleast one service to your current order',
              style: TextStyle(fontFamily: 'SourceSansPro'),
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
        flat: _addressSeen.flat,
        landmark: _addressSeen.landmark,
        make: Provider.of<Bikes>(context, listen: false).activeBike.brand,
        model: Provider.of<Bikes>(context, listen: false).activeBike.model,
        status: _orderItem.status,
        rideable: _orderItem.rideable,
        serviceType: _orderItem.serviceType,
        date: _orderItem.date,
        time: _orderItem.time,
        deliveryType: _orderItem.deliveryType,
      );
      await Provider.of<Orders>(context, listen: false)
          .addOrder(_orderItem, _prottoBucks);
      Provider.of<Cart>(context, listen: false).resetCart();
      Navigator.of(context).pop();
    }
  }

  String _getReferalDiscount(Cart cart) {
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

  String _getNewTotal(Cart cart) {
    var totalBefore = cart.getTotal();
    return '${(totalBefore - double.parse(_getReferalDiscount(cart)))}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            fontFamily: 'Montserrrat',
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
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
                  fontSize: 24,
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
                  cart.getTotal().toString(),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Referal Discount',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                trailing: Text(
                  _getReferalDiscount(cart),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
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
                  _getNewTotal(cart),
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
                decoration: InputDecoration(
                  hintText: 'Enter Voucher Code',
                  hintStyle: TextStyle(fontFamily: 'SourceSansPro'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  suffixIcon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: InkWell(
                      child: Text(
                        'APPLY',
                        style: TextStyle(
                          fontFamily: 'SourceSansProSB',
                          color: Colors.deepOrange,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      style:
                          TextStyle(fontFamily: 'SourceSansPro', fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
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
                              style: TextStyle(fontFamily: 'SourceSansPro'),
                            ),
                            value: value);
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
                          make: _orderItem.make,
                          model: _orderItem.model,
                          status: _orderItem.status,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Is Bike rideable?',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: _pressedOne
                                  ? BorderSide()
                                  : BorderSide(color: Colors.deepOrange),
                            ),
                            elevation: 2,
                            color:
                                _pressedOne ? Colors.deepOrange : Colors.white,
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontFamily: 'SourceSansProSB',
                                fontSize: 15,
                                color:
                                    _pressedOne ? Colors.white : Colors.black,
                              ),
                            ),
                            onPressed: () {
                              if (_pressedOne) {
                                return;
                              }
                              setState(() {
                                _pressedOne = !_pressedOne;
                                if (_pressedTwo) {
                                  _pressedTwo = !_pressedTwo;
                                }
                              });
                              _orderItem = OrderItem(
                                id: _orderItem.id,
                                bookingId: _orderItem.bookingId,
                                address: _orderItem.address,
                                bikeid: _orderItem.bikeid,
                                bikeNumber: _orderItem.bikeNumber,
                                bikeYear: _orderItem.bikeYear,
                                flat: _orderItem.flat,
                                landmark: _orderItem.landmark,
                                make: _orderItem.make,
                                model: _orderItem.model,
                                status: _orderItem.status,
                                rideable: 'Yes',
                                serviceType: _orderItem.serviceType,
                                date: _orderItem.date,
                                time: _orderItem.time,
                                deliveryType: _orderItem.deliveryType,
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: _pressedTwo
                                  ? BorderSide()
                                  : BorderSide(color: Colors.deepOrange),
                            ),
                            elevation: 2,
                            color:
                                _pressedTwo ? Colors.deepOrange : Colors.white,
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontFamily: 'SourceSansProSB',
                                fontSize: 15,
                                color:
                                    _pressedTwo ? Colors.white : Colors.black,
                              ),
                            ),
                            onPressed: () {
                              if (_pressedTwo) {
                                return;
                              }
                              setState(() {
                                _pressedTwo = !_pressedTwo;
                                if (_pressedOne) {
                                  _pressedOne = !_pressedOne;
                                }
                              });
                              _orderItem = OrderItem(
                                id: _orderItem.id,
                                bookingId: _orderItem.bookingId,
                                address: _orderItem.address,
                                bikeid: _orderItem.bikeid,
                                bikeNumber: _orderItem.bikeNumber,
                                bikeYear: _orderItem.bikeYear,
                                flat: _orderItem.flat,
                                landmark: _orderItem.landmark,
                                make: _orderItem.make,
                                model: _orderItem.model,
                                status: _orderItem.status,
                                rideable: 'No',
                                serviceType: _orderItem.serviceType,
                                date: _orderItem.date,
                                time: _orderItem.time,
                                deliveryType: _orderItem.deliveryType,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Select Date and Time',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: RaisedButton(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _date == null ? 'Date' : _date,
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color.fromRGBO(128, 128, 128, 1),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
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
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Time Slot',
                        hintStyle: TextStyle(
                          fontFamily: 'SourceSansPro',
                          color: Color.fromRGBO(128, 128, 128, 1),
                          fontSize: 14,
                        ),
                      ),
                      items: _getTime().map<DropdownMenuItem>((value) {
                        return DropdownMenuItem<String>(
                            child: Text(value), value: value);
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
                          flat: _orderItem.flat,
                          landmark: _orderItem.landmark,
                          make: _orderItem.make,
                          model: _orderItem.model,
                          status: _orderItem.status,
                          rideable: _orderItem.rideable,
                          serviceType: _orderItem.serviceType,
                          date: _orderItem.date,
                          time: value,
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
                          fontFamily: 'SourceSansProSB', fontSize: 15),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            _addressSeen.saveas,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color.fromRGBO(
                                                  112, 112, 112, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
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
                                                fontFamily: 'SourceSansPro',
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      _addressSeen.landmark != null
                                          ? Text(
                                              '${_addressSeen.landmark}, ${_addressSeen.address}',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
                                              ),
                                            )
                                          : Text(
                                              _addressSeen.address,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
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
                  SizedBox(height: 10),
                  _addressSeen == null
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 40,
                                child: RaisedButton(
                                  color: Colors.white,
                                  child: Text(
                                    'Add Address',
                                    style: TextStyle(
                                      fontFamily: 'SourceSansProSB',
                                      fontSize: 15,
                                    ),
                                  ),
                                  elevation: 2,
                                  onPressed: () async {
                                    final result = await Navigator.of(context,
                                            rootNavigator: true)
                                        .push(addAddressScreenPageRoute());
                                    setState(() {
                                      if (result != null) {
                                        _addressSeen = result;
                                      }
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 40,
                                child: RaisedButton(
                                  color: Colors.deepOrange,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 40,
                                child: RaisedButton(
                                  color: Colors.white,
                                  child: Text(
                                    'Pay Later',
                                    style: TextStyle(
                                        fontFamily: 'SourceSansProSB'),
                                  ),
                                  elevation: 2,
                                  onPressed: _saveForm,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 40,
                                child: RaisedButton(
                                  color: Colors.deepOrange,
                                  child: Text(
                                    'Pay Now',
                                    style: TextStyle(
                                        fontFamily: 'SourceSansProSB',
                                        color: Colors.white),
                                  ),
                                  onPressed: () {},
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
      ),
    );
  }
}
