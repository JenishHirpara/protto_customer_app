import 'package:flutter/cupertino.dart';

class Bike with ChangeNotifier {
  final String brand;
  final String model;
  final String year;
  final String number;

  Bike({
    @required this.brand,
    @required this.model,
    @required this.year,
    @required this.number,
  });
}

class Bikes with ChangeNotifier {
  List<Bike> _items = [
    Bike(
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
}
