import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/rgservice_item.dart';
import './shopping_cart_screen.dart';
import 'user_profile_screen.dart';

Color orangeColor = new Color(0xFFF69C7A);
Color greyColor = new Color(0xFFC2C2C2);

var tabsLength = 3;

class ServiceScreen extends StatefulWidget {
  final int i;

  ServiceScreen(this.i);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  PageRouteBuilder shoppingCartRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ShoppingCartScreen();
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

  PageRouteBuilder profileScreenPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return UserProfileScreen();
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.i,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Yamaha FZ',
            style: GoogleFonts.montserrat(
              color: Colors.deepOrange,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
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
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).push(shoppingCartRouteBuilder());
              },
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 40),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.deepOrange,
            tabs: [
              Tab(
                text: "Regular Service",
              ),
              Tab(text: "Tyre"),
              Tab(text: "Wash + Coat"),
              Tab(text: "Custom Repairs"),
              Tab(text: "Denting & Painting"),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: TabBarView(
            children: <Widget>[
              regularServicesPage(),
              regularServicesPage(),
              regularServicesPage(),
              regularServicesPage(),
              regularServicesPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget regularServicesPage() {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        RgServiceItem(
          price: 1599,
          type: 'PRODRY',
        ),
        RgServiceItem(
          price: 1599,
          type: 'PROWET',
        ),
      ],
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
