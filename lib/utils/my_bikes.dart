import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/bikes.dart';

class MyBikes extends StatelessWidget {
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
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
