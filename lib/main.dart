import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/verify_phone_screen.dart';
import './providers/orders.dart';
import './providers/bikes.dart';
import './providers/cart_item.dart';
import './providers/address.dart';
import './providers/profile.dart';
import './screens/signup_screen.dart';
import './screens/navigationBarScreen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(241, 93, 36, .1),
  100: Color.fromRGBO(241, 93, 36, .2),
  200: Color.fromRGBO(241, 93, 36, .3),
  300: Color.fromRGBO(241, 93, 36, .4),
  400: Color.fromRGBO(241, 93, 36, .5),
  500: Color.fromRGBO(241, 93, 36, .6),
  600: Color.fromRGBO(241, 93, 36, .7),
  700: Color.fromRGBO(241, 93, 36, .8),
  800: Color.fromRGBO(241, 93, 36, .9),
  900: Color.fromRGBO(241, 93, 36, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFF15D24, color);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProfile(),
        ),
        ChangeNotifierProxyProvider<UserProfile, Orders>(
          update: (ctx, userprofile, previousOrders) => Orders(
            userprofile.item == null ? null : userprofile.item.id,
            previousOrders == null ? [] : previousOrders.items,
          ),
        ),
        ChangeNotifierProxyProvider<UserProfile, Bikes>(
          update: (ctx, userprofile, previousBikes) => Bikes(
            userprofile.item == null ? null : userprofile.item.id,
            previousBikes == null ? [] : previousBikes.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<UserProfile, Addresses>(
          update: (ctx, userprofile, previousAddresses) => Addresses(
            userprofile.item == null ? null : userprofile.item.id,
            previousAddresses == null ? [] : previousAddresses.items,
          ),
        ),
      ],
      child: Consumer<UserProfile>(
        builder: (ctx, profile, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Protto',
          theme: ThemeData(
            primarySwatch: colorCustom,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: profile.isAuth
              ? NavigationBarScreen()
              : FutureBuilder(
                  future: profile.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : HomeScreen(),
                ),
          routes: {
            VerifyPhoneScreen.routeName: (ctx) => VerifyPhoneScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
          },
        ),
      ),
    );
  }
}
