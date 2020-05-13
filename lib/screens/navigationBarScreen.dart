import 'package:flutter/material.dart';

import '../screens/order_details_screen.dart';
import '../screens/dashboard_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void initState() {
    _pages = [
      {
        'page': DashBoardScreen(),
        'appbar': AppBar(
          title: Text(
            'Yamaha FZ',
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 20,
            ),
          ),
          leading: Container(),
          elevation: 0,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: greyColor,
              ),
              onPressed: () {
                // TODO Account icon on pressed...
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: greyColor,
              ),
              onPressed: () {
                // TODO Cart icon on pressed...
              },
            )
          ],
        ),
      },
      {
        'page': Scaffold(),
        'appbar': AppBar(),
      },
      {
        'page': OrderDetailsScreen(),
        'appbar': AppBar(
          title: Text(
            'Order Details',
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 20,
            ),
          ),
          leading: Container(),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
      },
      {
        'page': Scaffold(),
        'appbar': AppBar(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_selectedPageIndex]['appbar'],
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        iconSize: 30,
        currentIndex: _selectedPageIndex,
        //type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: new Icon(Icons.home), title: Text('')),
          BottomNavigationBarItem(
              icon: new Icon(Icons.search), title: Text('')),
          BottomNavigationBarItem(
              icon: new Icon(Icons.event_note), title: Text('')),
          BottomNavigationBarItem(
              icon: new Icon(Icons.flash_on), title: Text(''))
        ],
      ),
    );
  }
}
