import 'package:flutter/material.dart';

class Address with ChangeNotifier {
  final String id;
  final String address;
  final String landmark;
  final String saveas;

  Address({
    @required this.id,
    @required this.address,
    @required this.landmark,
    @required this.saveas,
  });
}

class Addresses with ChangeNotifier {
  List<Address> _items = [
    Address(
      id: DateTime.now().toString(),
      address: '701, Landmark, RM Road, Vile Parle',
      landmark: '',
      saveas: 'Home',
    ),
  ];

  List<Address> get items {
    return [..._items];
  }

  void addAddress(Address newAddress) {
    _items.insert(0, newAddress);
    notifyListeners();
  }

  void editAddress(String id, Address newAddress) {
    final addressIndex = _items.indexWhere((address) => address.id == id);
    if (addressIndex >= 0) {
      _items[addressIndex] = newAddress;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteAddress(String add) {
    _items.removeWhere((address) => address.address == add);
    notifyListeners();
  }
}
