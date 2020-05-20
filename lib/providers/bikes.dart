import 'package:flutter/material.dart';

class Bike with ChangeNotifier {
  final String id;
  final String brand;
  final String model;
  final String year;
  final String number;

  Bike({
    @required this.id,
    @required this.brand,
    @required this.model,
    @required this.year,
    @required this.number,
  });
}

class Bikes with ChangeNotifier {
  List<Bike> _items = [
    Bike(
      id: DateTime.now().toString(),
      brand: 'Yamaha',
      model: 'FZ',
      year: '2017',
      number: 'MH 02 KG 0904',
    ),
  ];

  List<Bike> get items {
    return [..._items];
  }

  void addBike(Bike newBike) {
    _items.add(newBike);
    notifyListeners();
  }

  void updateBike(Bike bike, String id) {
    final bikeIndex = _items.indexWhere((bike) => bike.id == id);
    if (bikeIndex >= 0) {
      _items[bikeIndex] = bike;
      notifyListeners();
    }
  }

  void deleteBike(String number) {
    _items.removeWhere((bike) => bike.number == number);
    notifyListeners();
  }
}
