import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './dashboard_screen.dart';
import './flash_screen.dart';
import './order_details_screen.dart';
import './search_screen.dart';

import '../providers/bikes.dart';
import '../providers/address.dart';
import '../providers/cart_item.dart';
import '../utils/badge.dart';
import './user_profile_screen.dart';
import './shopping_cart_screen.dart';
import './my_bikes_screen.dart';
import './new_bike_screen.dart';
import './no_internet_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _currentIndex = 0;
  List<Map<String, Object>> _pages;
  PageRouteBuilder profileScreenPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return UserProfileScreen();
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

  PageRouteBuilder shoppingCartRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ShoppingCartScreen();
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

  PageRouteBuilder myBikesRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return MyBikesScreen();
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

  PageRouteBuilder newBikeRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NewBikeScreen();
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

  Future showPopup(Bike activebike) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          height: 245,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
                  child: InkWell(
                    child: Icon(
                      Icons.clear,
                      size: 24,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Container(
                height: 160,
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    activebike != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${activebike.brand}',
                                textAlign: TextAlign.start,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${activebike.model}',
                                textAlign: TextAlign.start,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'My Bike',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Theme.of(context).primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Year: ',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color.fromRGBO(100, 100, 100, 0.9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          activebike != null ? activebike.year : 'My Bike',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color.fromRGBO(100, 100, 100, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Registration Number: ',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color.fromRGBO(100, 100, 100, 0.9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          activebike != null ? activebike.number : '',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color.fromRGBO(100, 100, 100, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Container(
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: Colors.white,
                          child: Text(
                            'Manage',
                            style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              color: Color.fromRGBO(100, 100, 100, 1),
                            ),
                          ),
                          elevation: 0,
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).push(myBikesRouteBuilder());
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                endIndent: 10,
                indent: 10,
                thickness: 1,
                height: 0,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: FlatButton(
                    child: Text(
                      'Add New Bike',
                      style: TextStyle(
                        fontFamily: 'SourceSansProSB',
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).push(newBikeRouteBuilder());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void retry() async {
    try {
      Provider.of<Addresses>(context, listen: false).fetchAndSetAddresses();
      await Provider.of<Bikes>(context, listen: false).fetchAndSetBikes();
      setState(() {
        _isLoading = false;
        _isInternet = true;
      });
    } catch (error) {
      if (error.message.toString().contains('Failed host lookup')) {
        setState(() {
          _isLoading = false;
          _isInternet = false;
        });
      }
    }
  }

  var _isInit = true;
  var _isLoading = true;
  var _isInternet = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      try {
        Provider.of<Addresses>(context, listen: false).fetchAndSetAddresses();
        await Provider.of<Bikes>(context, listen: false).fetchAndSetBikes();
        setState(() {
          _isLoading = false;
          _isInternet = true;
        });
      } catch (error) {
        if (error.message.toString().contains('Failed host lookup')) {
          setState(() {
            _isLoading = false;
            _isInternet = false;
          });
        }
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _selectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activebike = Provider.of<Bikes>(context).activeBike;
    _pages = [
      {
        'page': DashBoardScreen(),
        'appbar': AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () => showPopup(activebike),
            child: activebike != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${activebike.brand}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Theme.of(context).primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${activebike.model}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : Text(
                    '+ Add a Bike',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          titleSpacing: 20,
          elevation: 0,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).push(profileScreenPageRoute());
              },
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(child: ch, value: cart.itemCount.toString()),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(shoppingCartRouteBuilder());
                },
              ),
            ),
          ],
        ),
      },
      {
        'page': SearchScreen(),
        'appbar': AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Search Services',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          titleSpacing: 20,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
      },
      {
        'page': OrderDetailsScreen(),
        'appbar': AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Order Details',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          titleSpacing: 20,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
      },
      {
        'page': FlashScreen(),
        'appbar': AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Referral',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          titleSpacing: 20,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
      },
    ];
    return Scaffold(
      appBar: _isLoading
          ? null
          : _isInternet ? _pages[_currentIndex]['appbar'] : null,
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
              ? _pages[_currentIndex]['page']
              : NoInternetScreen(retry),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 3.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: BottomNavigationBar(
          onTap: (index) => _selectPage(index),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.shifting,
          elevation: 5,
          iconSize: 30,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.event_note),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.flash_on),
              title: Text(''),
            )
          ],
        ),
      ),
    );
  }
}
