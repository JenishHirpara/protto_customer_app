import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/verify_phone_screen.dart';
import './providers/orders.dart';

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
      ],
      child: MaterialApp(
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
