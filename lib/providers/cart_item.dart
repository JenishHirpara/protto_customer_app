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
  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  int findByType(String type) {
    return _items.indexWhere((cartitem) => cartitem.type == type);
  }

  String getId(int index) {
    return _items[index].id;
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
    var index = _items.indexWhere((cart) => cart.id == item.id);
    _items.removeAt(index);
    notifyListeners();
  }

  void replaceItem(CartItem item) {
    var index = _items.indexWhere((cart) => cart.service == 'Regular Service');
    _items[index] = item;
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

  void logout() async {
    _items.clear();
    notifyListeners();
  }
}
