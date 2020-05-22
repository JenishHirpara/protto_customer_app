import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/shopping_cart_item.dart';
import '../providers/cart_item.dart';
import '../providers/address.dart';
import './select_address_screen.dart';
import './add_address_screen.dart';

class ShoppingCartScreen extends StatelessWidget {
  Future selectAddress(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SelectAddressScreen(),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    final addresses = Provider.of<Addresses>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.montserrat(
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: cart.items[i],
                child: ShoppingCartItem(),
              ),
              itemCount: cart.items.length,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Totals',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Item Total',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                  ),
                ),
                trailing: Text(
                  cart.getTotal().toString(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                enabled: true,
                decoration: InputDecoration(
                  hintText: 'Enter Voucher Code',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  suffixIcon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: InkWell(
                      child: Text(
                        'APPLY',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                      onTap: () {},
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select Delivery Type',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Delivery Type',
                  hintStyle: GoogleFonts.cantataOne(
                    color: Color.fromRGBO(128, 128, 128, 1),
                    fontSize: 14,
                  ),
                ),
                items: <String>['Pick & Drop', 'Self Delivery']
                    .map<DropdownMenuItem>((value) {
                  return DropdownMenuItem<String>(
                      child: Text(value), value: value);
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please provide delivery type';
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select Time Slot',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Time Slot',
                  hintStyle: GoogleFonts.cantataOne(
                    color: Color.fromRGBO(128, 128, 128, 1),
                    fontSize: 14,
                  ),
                ),
                items: <String>['10-11am', '11-12pm']
                    .map<DropdownMenuItem>((value) {
                  return DropdownMenuItem<String>(
                      child: Text(value), value: value);
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please provide time slot';
                  }
                  return null;
                },
                onChanged: (_) {},
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select Address',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Offstage(
                offstage: false,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    addresses.items.isNotEmpty
                        ? Text(
                            '${addresses.items[0].address}, ${addresses.items[0].landmark}',
                            style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(112, 112, 112, 1),
                            ),
                          )
                        : Text(
                            'Please select an address',
                            style: GoogleFonts.montserrat(
                              color: Color.fromRGBO(112, 112, 112, 1),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text('ADD ADDRESS'),
                      elevation: 2,
                      onPressed: () {
                        Navigator.of(context).push(addAddressScreenPageRoute());
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      child: Text(
                        'SELECT ADDRESS',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => selectAddress(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text('PAY LATER'),
                      elevation: 2,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      child: Text(
                        'PAY NOW',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
