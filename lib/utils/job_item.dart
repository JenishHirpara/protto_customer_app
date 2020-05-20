import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';

class JobItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartitem = Provider.of<CartItem>(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Text(
        cartitem.type,
        style: GoogleFonts.cantataOne(
          color: Color.fromRGBO(128, 128, 128, 1),
        ),
      ),
      subtitle: Text(
        cartitem.service,
        style: GoogleFonts.cantataOne(
          color: Color.fromRGBO(150, 150, 150, 1),
        ),
      ),
      trailing: Container(
        width: 100,
        height: 20,
        child: Text(
          '₹ ${cartitem.price.toString()}',
          style: GoogleFonts.cantataOne(
            color: Color.fromRGBO(128, 128, 128, 1),
          ),
        ),
      ),
    );
  }
}
