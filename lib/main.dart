import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/verify_phone_screen.dart';
import './providers/orders.dart';
import './providers/bikes.dart';
import './providers/cart_item.dart';
import './providers/address.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ActiveOrders(),
        ),
        ChangeNotifierProvider.value(
          value: PastOrders(),
        ),
        ChangeNotifierProvider.value(
          value: Bikes(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Addresses(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Protto',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          VerifyPhoneScreen.routeName: (ctx) => VerifyPhoneScreen(),
        },
      ),
    );
  }
}
