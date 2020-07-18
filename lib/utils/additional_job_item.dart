import 'package:flutter/material.dart';

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
        style: TextStyle(
          fontFamily: 'SourceSansProSB',
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(128, 128, 128, 1),
        ),
      ),
      trailing: Container(
        width: 100,
        height: 20,
        child: Text(
          '₹ ${job.cost}',
          style: TextStyle(
            fontFamily: 'SourceSansProSB',
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(128, 128, 128, 1),
          ),
        ),
      ),
    );
  }
}
