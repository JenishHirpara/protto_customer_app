import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';

class PastOrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<PastOrderItem>(context);
    print(order.date);
    return Container(
      width: double.infinity,
      height: 115,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepOrange,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    order.name,
                    style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(241, 93, 36, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Booking ID:',
                      style: GoogleFonts.cantataOne(
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      order.id,
                      style: GoogleFonts.cantataOne(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text(
                      'Service Date:',
                      style: GoogleFonts.cantataOne(
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yyyy').format(order.date),
                      style: GoogleFonts.cantataOne(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Status:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      order.status,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
