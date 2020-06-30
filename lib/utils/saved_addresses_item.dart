import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';
import '../screens/edit_address_screen.dart';

class SavedAddressesItem extends StatelessWidget {
  Future _confirmDelete(BuildContext originalcontext, Address address) {
    return showDialog(
      context: originalcontext,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you sure?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        content: Text(
          'Are you sure you want to delete ${address.saveas}',
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

  PageRouteBuilder editAddressScreenPageRoute(Address address) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return EditAddressScreen(address);
      },
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
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
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(editAddressScreenPageRoute(address));
              },
            ),
            InkWell(
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
          ],
        ),
      ),
    );
  }
}
