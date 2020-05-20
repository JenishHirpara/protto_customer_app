import 'package:flutter/material.dart';

class SelectAddressItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ListTile(
        leading: GestureDetector(
          child: Icon(Icons.radio_button_unchecked),
        ),
        title: Text('Home'),
        subtitle: Text('701, Landmark, RM Road, Vile Parle'),
      ),
    );
  }
}
