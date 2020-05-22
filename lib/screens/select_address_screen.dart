import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/select_address_item.dart';
import '../providers/address.dart';

class SelectAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addresses = Provider.of<Addresses>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(24),
            child: Text(
              'Select Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: addresses.items[i],
              child: Column(
                children: <Widget>[
                  SelectAddressItem(),
                  SizedBox(height: 10),
                  Divider(
                    endIndent: 40,
                    indent: 40,
                    color: Color.fromRGBO(200, 200, 200, 1),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            itemCount: addresses.items.length,
          ),
        ],
      ),
    );
  }
}
