import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';

class SelectAddressItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final address = Provider.of<Address>(context);
    return Container(
      height: 50,
      width: double.infinity,
      child: ListTile(
        leading: GestureDetector(
          child: Icon(Icons.radio_button_unchecked),
        ),
        title: Text(address.saveas),
        subtitle: Text('${address.address}, ${address.landmark}'),
      ),
    );
  }
}
