import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/orders.dart';

class AdditionalJobItem extends StatelessWidget {
  final Jobs job;

  AdditionalJobItem(this.job);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Text(
        job.name,
        style: GoogleFonts.cantataOne(
          color: Color.fromRGBO(128, 128, 128, 1),
        ),
      ),
      trailing: Container(
        width: 100,
        height: 20,
        child: Text(
          '₹ ${job.cost}',
          style: GoogleFonts.cantataOne(
            color: Color.fromRGBO(128, 128, 128, 1),
          ),
        ),
      ),
    );
  }
}
