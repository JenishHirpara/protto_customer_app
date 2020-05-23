import 'package:flutter/material.dart';

import './dashboard_screen.dart';
import './order_details_screen.dart';
import './navigationBarScreen.dart';
import './flash_screen.dart';
import './search_screen.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(
    BuildContext context,
  ) {
    Widget page;
    switch (tabItem) {
      case TabItem.dashboard:
        page = DashBoardScreen();
        break;
      case TabItem.search:
        page = SearchScreen();
        break;
      case TabItem.orders:
        page = OrderDetailsScreen();
        break;
      case TabItem.flash:
        page = FlashScreen();
        break;
    }
    return {
      TabNavigatorRoutes.root: (context) => page,
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
