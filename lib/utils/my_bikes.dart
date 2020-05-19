import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/bikes.dart';
import '../screens/edit_bike_screen.dart';

class MyBikes extends StatelessWidget {
  PageRouteBuilder editBikeRouteBuilder(Bike bike) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return EditBikeScreen(bike);
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

  Future _handleDelete(BuildContext originalcontext, Bike bike) {
    return showDialog(
      context: originalcontext,
      builder: (context) => AlertDialog(
        title: Text('Delete ${bike.brand} ${bike.model}?'),
        content: Text('Are you sure you want to delete this bike?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Provider.of<Bikes>(originalcontext, listen: false)
                  .deleteBike(bike.number);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bike = Provider.of<Bike>(context);
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: 130,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${bike.brand} ${bike.model}',
                      style: GoogleFonts.montserrat(
                        color: Colors.deepOrange,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      bike.year,
                      style: GoogleFonts.cantataOne(
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      bike.number,
                      style: GoogleFonts.cantataOne(
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(editBikeRouteBuilder(bike));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () => _handleDelete(context, bike),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
