import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  TabItem get item {
    switch (_currentIndex) {
      case 0:
        return TabItem.dashboard;
        break;
      case 1:
        return TabItem.search;
        break;
      case 2:
        return TabItem.orders;
        break;
      case 3:
        return TabItem.flash;
        break;
    }
    return TabItem.dashboard;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[item].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentIndex != 0) {
            // select 'main' tab
            setState(() {
              _currentIndex = 0;
              _selectedPageIndex = TabItem.dashboard;
            });
            // back button handled by app
            return false;
          } else {
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text('Do you wish to exit the app?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        SystemNavigator.pop();
                      },
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('No')),
                  ],
                );
              },
            );
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(TabItem.dashboard),
            _buildOffstageNavigator(TabItem.search),
            _buildOffstageNavigator(TabItem.orders),
            _buildOffstageNavigator(TabItem.flash),
          ],
        ),
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
      ),
    );
  }
}
