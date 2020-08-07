import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';

class SavedAddressesItem extends StatelessWidget {
  Future<void> _confirmDelete(BuildContext originalcontext, Address address) {
    if (address.active == '1') {
      return showDialog(
        context: originalcontext,
        builder: (context) => AlertDialog(
          title: Text(
            'Request not possible',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          content: Text(
            'This address is associated with a booking therefore cannot be deleted',
            style: TextStyle(fontFamily: 'SourceSansPro'),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: originalcontext,
        builder: (context) => AlertDialog(
          title: Text(
            'Are you sure?',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          content: Text(
            'Are you sure you want to delete ${address.saveas}?',
            style: TextStyle(fontFamily: 'SourceSansPro'),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                await Provider.of<Addresses>(context, listen: false)
                    .deleteAddress(address.id);
                Navigator.of(context).pop();
              },
              child: Text(
                'Yes',
                style: TextStyle(fontFamily: 'SourceSansProSB'),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(fontFamily: 'SourceSansProSB'),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<Address>(context);
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(address.saveas),
      subtitle: address.landmark != ''
          ? Text(
              '${address.flat}, ${address.landmark}, ${address.address}',
              style: TextStyle(fontFamily: 'SourceSansPro'),
            )
          : Text(
              '${address.flat}, ${address.address}',
              style: TextStyle(fontFamily: 'SourceSansPro'),
            ),
      trailing: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.delete,
            size: 20,
          ),
        ),
        onTap: () => _confirmDelete(context, address),
      ),
    );
  }
}
