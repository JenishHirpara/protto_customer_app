import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';
import '../utils/saved_addresses_item.dart';
import './add_address_screen.dart';
import './edit_address_screen.dart';

class SavedAddressesScreen extends StatefulWidget {
  @override
  _SavedAddressesScreenState createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  PageRouteBuilder addAddressScreenPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AddAddressScreen();
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
    final addresses = Provider.of<Addresses>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Addresses',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: addresses.items[i],
              child: Column(
                children: <Widget>[
                  SavedAddressesItem(),
                  Divider(),
                ],
              ),
            ),
            itemCount: addresses.items.length,
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange),
            ),
            child: RaisedButton(
              elevation: 0,
              color: Color.fromRGBO(250, 250, 250, 1),
              child: Text(
                'Add Address',
                style: TextStyle(fontFamily: 'SourceSansProSB', fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).push(addAddressScreenPageRoute());
              },
            ),
          ),
        ],
      ),
    );
  }
}
