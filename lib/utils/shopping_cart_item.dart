import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_item.dart';

class ShoppingCartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartitem = Provider.of<CartItem>(context);
    final cart = Provider.of<Cart>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: double.infinity,
      height: 120,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              cartitem.type,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color.fromRGBO(112, 112, 112, 1),
              ),
            ),
            subtitle: Text(
              cartitem.service,
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
            trailing: Text(
              '${cartitem.price} ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color.fromRGBO(112, 112, 112, 1),
                //color: Colors.deepOrange,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  cart.deleteItem(cartitem.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
