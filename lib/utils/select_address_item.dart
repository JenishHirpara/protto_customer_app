import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';

class SelectAddressItem extends StatelessWidget {
  final Address addressSeen;

  SelectAddressItem(this.addressSeen);

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<Address>(context, listen: false);
    return InkWell(
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: GestureDetector(
                child: addressSeen == address
                    ? Icon(
                        Icons.radio_button_checked,
                        color: Theme.of(context).primaryColor,
                      )
                    : Icon(
                        Icons.radio_button_unchecked,
                        color: Theme.of(context).primaryColor,
                      ),
              ),
              title: Text(address.saveas),
              subtitle: address.landmark != ''
                  ? Text(
                      '${address.flat}, ${address.landmark}, ${address.address}',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                      ),
                    )
                  : Text(
                      '${address.flat}, ${address.address}',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                      ),
                    ),
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
