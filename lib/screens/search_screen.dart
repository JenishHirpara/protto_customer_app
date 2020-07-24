import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bikes.dart';
import '../providers/cart_item.dart';
import './rg_details_screen.dart';
import './custom_repairs_detail_screen.dart';
import './no_internet_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _editingController = TextEditingController();

  List<CartItem> services = [];

  void retry() async {
    try {
      final activeBike = Provider.of<Bikes>(context, listen: false).activeBike;
      setState(() {
        _isLoading = true;
        _isInternet = true;
      });
      await Provider.of<Bikes>(context, listen: false)
          .getRgPrice(activeBike.brand, activeBike.model);
      setState(() {
        _isLoading = false;
      });
      services = [
        CartItem(
          id: DateTime.now().toString(),
          service: 'Regular Service',
          type: 'PRODRY',
          price: activeBike != null
              ? double.parse(Provider.of<Bikes>(context, listen: false).proDry)
              : 0.0,
        ),
        CartItem(
          id: DateTime.now().toString(),
          service: 'Regular Service',
          type: 'PROWET',
          price: activeBike != null
              ? double.parse(Provider.of<Bikes>(context, listen: false).proWet)
              : 0.0,
        ),
        CartItem(
          id: DateTime.now().toString(),
          service: 'Custom Repairs',
          type: 'Insurance Claim',
          price: activeBike != null ? 149 : 0.0,
        ),
        CartItem(
          id: DateTime.now().toString(),
          service: 'Custom Repairs',
          type: 'Brake Inspection',
          price: activeBike != null ? 149 : 0.0,
        ),
        CartItem(
          id: DateTime.now().toString(),
          service: 'Custom Repairs',
          type: 'Electrical Inspection',
          price: activeBike != null ? 149 : 0.0,
        ),
        CartItem(
          id: DateTime.now().toString(),
          service: 'Custom Repairs',
          type: 'Clutch Inspection',
          price: activeBike != null ? 149 : 0.0,
        ),
        CartItem(
          id: DateTime.now().toString(),
          service: 'Custom Repairs',
          type: 'Other',
          price: activeBike != null ? 149 : 0.0,
        ),
      ];
      display.addAll(services);
    } catch (error) {
      print(error.message);
      if (error.message.toString().contains('Failed host lookup')) {
        setState(() {
          _isLoading = false;
          _isInternet = false;
        });
      }
    }
  }

  var display = List<CartItem>();
  var _isInit = true;
  var _isLoading = false;
  var _isInternet = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      final activeBike = Provider.of<Bikes>(context).activeBike;
      if (activeBike != null) {
        try {
          setState(() {
            _isLoading = true;
            _isInternet = true;
          });
          await Provider.of<Bikes>(context, listen: false)
              .getRgPrice(activeBike.brand, activeBike.model);
          setState(() {
            _isLoading = false;
          });
          services = [
            CartItem(
              id: DateTime.now().toString(),
              service: 'Regular Service',
              type: 'PRODRY',
              price: activeBike != null
                  ? double.parse(
                      Provider.of<Bikes>(context, listen: false).proDry)
                  : 0.0,
            ),
            CartItem(
              id: DateTime.now().toString(),
              service: 'Regular Service',
              type: 'PROWET',
              price: activeBike != null
                  ? double.parse(
                      Provider.of<Bikes>(context, listen: false).proWet)
                  : 0.0,
            ),
            CartItem(
              id: DateTime.now().toString(),
              service: 'Custom Repairs',
              type: 'Insurance Claim',
              price: activeBike != null ? 149 : 0.0,
            ),
            CartItem(
              id: DateTime.now().toString(),
              service: 'Custom Repairs',
              type: 'Brake Inspection',
              price: activeBike != null ? 149 : 0.0,
            ),
            CartItem(
              id: DateTime.now().toString(),
              service: 'Custom Repairs',
              type: 'Electrical Inspection',
              price: activeBike != null ? 149 : 0.0,
            ),
            CartItem(
              id: DateTime.now().toString(),
              service: 'Custom Repairs',
              type: 'Clutch Inspection',
              price: activeBike != null ? 149 : 0.0,
            ),
            CartItem(
              id: DateTime.now().toString(),
              service: 'Custom Repairs',
              type: 'Other',
              price: activeBike != null ? 149 : 0.0,
            ),
          ];
          display.addAll(services);
        } catch (error) {
          print(error.message);
          if (error.message.toString().contains('Failed host lookup')) {
            setState(() {
              _isLoading = false;
              _isInternet = false;
            });
          }
        }
      } else {
        services = [];
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void filterSearchResults(String query) {
    List<CartItem> dummySearchList = List<CartItem>();
    dummySearchList.addAll(services);
    if (query.isNotEmpty) {
      List<CartItem> dummyListData = List<CartItem>();
      dummySearchList.forEach((item) {
        if (item.type.toLowerCase().contains(query.toLowerCase()) ||
            item.service.toLowerCase().contains(query.toLowerCase()) ||
            item.service
                .toLowerCase()
                .replaceAll(' ', '')
                .contains(query.toLowerCase())) {
          dummyListData.add(item);
        } else {
          setState(() {
            display.clear();
          });
        }
      });
      setState(() {
        display.clear();
        display.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        display.clear();
        display.addAll(services);
      });
    }
  }

  PageRouteBuilder rgDetailRouteBuilder(int i) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return RgDetailsScreen(display[i]);
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

  PageRouteBuilder customRepairsRouteBuilder(int i) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return CustomRepairsDetailScreen(display[i]);
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

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _editingController,
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        decoration: new InputDecoration(
                          suffixIcon: GestureDetector(
                              child: Icon(
                                Icons.clear,
                                color: new Color(0xff626262),
                              ),
                              onTap: () {
                                _editingController.clear();
                              }),
                          prefixIcon: Icon(
                            Icons.search,
                            color: new Color(0xff626262),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          labelText: "Search Service",
                          hintText: "Search Service",
                          labelStyle: TextStyle(fontFamily: 'SourceSansPro'),
                          filled: true,
                          hintStyle: new TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: new Color(0xff1D1D1),
                          ),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) => InkWell(
                        child: ListTile(
                          title: Text(
                            display[i].type,
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(112, 112, 112, 1),
                            ),
                          ),
                          subtitle: Text(
                            display[i].service,
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ),
                        onTap: () {
                          if (display[i].type == 'PRODRY') {
                            Navigator.of(context).push(rgDetailRouteBuilder(0));
                          } else if (display[i].type == 'PROWET') {
                            Navigator.of(context).push(rgDetailRouteBuilder(1));
                          } else if (display[i].type == 'Insurance Claim') {
                            Navigator.of(context)
                                .push(customRepairsRouteBuilder(2));
                          } else if (display[i].type == 'Brake Inspection') {
                            Navigator.of(context)
                                .push(customRepairsRouteBuilder(3));
                          } else if (display[i].type ==
                              'Electrical Inspection') {
                            Navigator.of(context)
                                .push(customRepairsRouteBuilder(4));
                          } else if (display[i].type == 'Clutch Inspection') {
                            Navigator.of(context)
                                .push(customRepairsRouteBuilder(5));
                          } else if (display[i].type == 'Other') {
                            Navigator.of(context)
                                .push(customRepairsRouteBuilder(6));
                          }
                        },
                      ),
                      itemCount: display.length,
                    ),
                  ],
                ),
              )
            : NoInternetScreen(retry);
  }
}
