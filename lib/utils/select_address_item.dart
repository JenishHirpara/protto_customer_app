import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';

class SelectAddressItem extends StatelessWidget {
  final Address addressSeen;

  SelectAddressItem(this.addressSeen);

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<Address>(context);
    return InkWell(
      child: Container(
        height: 88,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: GestureDetector(
                child: addressSeen == address
                    ? Icon(
                        Icons.radio_button_checked,
                        color: Colors.deepOrange,
                      )
                    : Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.deepOrange,
                      ),
              ),
              title: Text(address.saveas),
              subtitle: Text('${address.address}, ${address.landmark}'),
            ),
            Divider(
              endIndent: 40,
              indent: 40,
              color: Color.fromRGBO(200, 200, 200, 1),
              thickness: 1,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pop(address);
      },
    );
  }
}
