import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
import './screens/no_internet_screen.dart';

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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var deviceToken;
  var _isInit = true;
  final storage = new FlutterSecureStorage();

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await storage.write(key: 'key', value: 'apikey');
      await storage.write(key: 'value', value: 'proflutter');
      await storage.write(key: 'username', value: 'rzp_live_6MErVr8nr9qQGG');
      await firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          alert: true,
          badge: true,
        ),
      );
      firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print('IOS setting registered');
      });
      await firebaseMessaging.getToken();
      //var _token = await firebaseMessaging.getToken();
      //print(_token);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void retry() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProfile(),
        ),
        ChangeNotifierProxyProvider<UserProfile, Orders>(
          create: (_) => Orders(null, []),
          update: (ctx, userprofile, previousOrders) => Orders(
            userprofile.item == null ? null : userprofile.item.id,
            previousOrders == null ? [] : previousOrders.items,
          ),
        ),
        ChangeNotifierProxyProvider<UserProfile, Bikes>(
          create: (_) => Bikes(null, []),
          update: (ctx, userprofile, previousBikes) => Bikes(
            userprofile.item == null ? null : userprofile.item.id,
            previousBikes == null ? [] : previousBikes.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<UserProfile, Addresses>(
          create: (_) => Addresses(null, []),
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
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return SplashScreen();
                    else if (snapshot.hasError) {
                      return Scaffold(body: NoInternetScreen(retry));
                    } else {
                      return HomeScreen();
                    }
                  },
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
