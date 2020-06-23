import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/select_address_item.dart';
import '../providers/address.dart';

class SelectAddressScreen extends StatefulWidget {
  final Address addressSeen;

  SelectAddressScreen(this.addressSeen);

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Addresses>(context, listen: false).fetchAndSetAddresses();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final addresses = Provider.of<Addresses>(context, listen: false);
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
                  SelectAddressItem(widget.addressSeen),
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
