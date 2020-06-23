import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String service;
  final String type;
  final double price;

  CartItem({
    @required this.id,
    @required this.service,
    @required this.type,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [
    // CartItem(
    //   id: DateTime.now().toString(),
    //   service: 'Regular Service',
    //   type: 'PRODRY',
    //   price: 1599,
    // ),
  ];

  List<CartItem> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  int findByType(String type) {
    return _items.indexWhere((cartitem) => cartitem.type == type);
  }

  double getTotal() {
    var total = 0.0;
    _items.forEach((item) {
      total = total + item.price;
    });

    return total;
  }

  void addItem(CartItem newItem) {
    _items.add(newItem);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void resetCart() {
    _items.clear();
    notifyListeners();
  }
}
