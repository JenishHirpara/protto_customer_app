import 'package:flutter/material.dart';

import './tab_navigator.dart';

enum TabItem { dashboard, search, orders, flash }

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  TabItem _selectedPageIndex = TabItem.dashboard;
  int _currentIndex = 0;

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.dashboard: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.orders: GlobalKey<NavigatorState>(),
    TabItem.flash: GlobalKey<NavigatorState>(),
  };

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
                              onPressed: () {},
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

  void _selectPage(TabItem tabItem, int index) {
    if (tabItem == _selectedPageIndex) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _selectedPageIndex = tabItem);
    }
    setState(() => _currentIndex = index);
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _selectedPageIndex != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _buildOffstageNavigator(TabItem.dashboard),
        _buildOffstageNavigator(TabItem.search),
        _buildOffstageNavigator(TabItem.orders),
        _buildOffstageNavigator(TabItem.flash),
      ]),
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
          onTap: (index) => _selectPage(TabItem.values[index], index),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          iconSize: 30,
          currentIndex: _currentIndex,
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
}
