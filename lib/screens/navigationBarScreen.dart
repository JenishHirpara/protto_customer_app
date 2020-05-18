import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protto_customer_app/screens/my_bikes_screen.dart';

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
          title: GestureDetector(
            onTap: () => showPopup(),
            child: Text(
              'Yamaha FZ',
              style: GoogleFonts.montserrat(
                color: Color.fromRGBO(241, 93, 36, 1),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              // style: TextStyle(
              //   color: Colors.deepOrange,
              //   fontSize: 20,
              // ),
            ),
          ),
          leading: Container(),
          elevation: 0,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              onPressed: () {
                // TODO Account icon on pressed...
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey,
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
      },
      {
        'page': Scaffold(),
        'appbar': AppBar(),
      },
    ];
    super.initState();
  }

  Future showPopup() {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          height: 210,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Icon(
                        Icons.motorcycle,
                        size: 75,
                        color: Color.fromRGBO(150, 150, 150, 1),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 110,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'My Bike',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromRGBO(100, 100, 100, 1),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('MH 02 KG 0904'),
                          SizedBox(height: 10),
                          Container(
                            width: 150,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              ),
                            ),
                            child: RaisedButton(
                              color: Colors.white,
                              child: Text('Manage'),
                              elevation: 0,
                              onPressed: () {
                                Navigator.of(context)
                                    .push(myBikesPageRoute());
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                endIndent: 10,
                indent: 10,
                thickness: 1,
                height: 0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: FlatButton(
                    child: Text(
                      '+ Add New Bike',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 3.0,
              color: Color.fromRGBO(241, 93, 36, 1),
            ),
          ),
        ),
        child: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          iconSize: 30,
          currentIndex: _selectedPageIndex,
          //type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: new Icon(Icons.home), title: Text('')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.search), title: Text('')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.event_note), title: Text('')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.flash_on), title: Text(''))
          ],
        ),
      ),
    );
  }


  PageRouteBuilder myBikesPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return MyBikesScreen();
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

}
