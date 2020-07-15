import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bikes.dart';
import '../utils/my_bikes.dart';
import './new_bike_screen.dart';

class MyBikesScreen extends StatefulWidget {
  @override
  _MyBikesScreenState createState() => _MyBikesScreenState();
}

class _MyBikesScreenState extends State<MyBikesScreen> {
  PageRouteBuilder newBikeRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NewBikeScreen();
      },
      transitionDuration: Duration(milliseconds: 300),
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
    final bikes = Provider.of<Bikes>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bikes',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: bikes.items[i],
                child: MyBikes(),
              ),
              itemCount: bikes.items.length,
            ),
            FlatButton(
              child: Text(
                'Add New Bike',
                style: TextStyle(
                  fontFamily: 'SourceSansProSB',
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(newBikeRouteBuilder());
              },
            ),
          ],
        ),
      ),
    );
  }
}
