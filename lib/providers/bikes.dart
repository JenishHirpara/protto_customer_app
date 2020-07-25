import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<Bike> _items = [];
  List<String> _brands = [];
  List<String> _models = [];
  Bike _activeBike;
  String _proDry;
  String _proWet;

  final String userId;

  Bikes(this.userId, this._items);

  List<Bike> get items {
    return [..._items];
  }

  List<String> get brands {
    return [..._brands];
  }

  Bike get activeBike {
    return _activeBike;
  }

  List<String> get models {
    return [..._models];
  }

  String get proDry {
    return _proDry;
  }

  String get proWet {
    return _proWet;
  }

  Future<void> fetchAndSetBikes() async {
    final url = 'http://stage.protto.in/api/hitesh/bike/$userId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Bike> data = [];

    if (extractedData['success'] == 'false') {
      return;
    }
    for (int i = 0; i < int.parse(extractedData['count']); i++) {
      data.insert(
        i,
        Bike(
          id: extractedData['bikes'][i]['bike_id'],
          brand: extractedData['bikes'][i]['make'],
          model: extractedData['bikes'][i]['model'],
          number: extractedData['bikes'][i]['bike_reg'],
          year: extractedData['bikes'][i]['year'],
        ),
      );
      if (extractedData['bikes'][i]['status'].toString() == '1') {
        _activeBike = Bike(
          id: extractedData['bikes'][i]['bike_id'],
          brand: extractedData['bikes'][i]['make'],
          model: extractedData['bikes'][i]['model'],
          number: extractedData['bikes'][i]['bike_reg'],
          year: extractedData['bikes'][i]['year'],
        );
        notifyListeners();
      }
    }
    _items = data;
    notifyListeners();
  }

  Future<void> fetchAllBrands() async {
    const url = 'http://stage.protto.in/api/prina/brand.php';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<String> brands = List<String>.from(extractedData['data']);
    _brands = brands;
    notifyListeners();
  }

  Future<void> fetchAllModels(String brand) async {
    final url = 'http://stage.protto.in/api/shivangi/models.php/$brand';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<String> models = [];
    models = List<String>.from(extractedData['data']);
    _models = models;
    notifyListeners();
  }

  Future<void> addBike(Bike newBike) async {
    final url = 'http://stage.protto.in/api/prina/addbike.php/$userId';
    if (_items.length == 0 || activeBike == null) {
      final response = await http.post(url,
          body: json.encode({
            'make': newBike.brand,
            'model': newBike.model,
            'bike_reg': newBike.number,
            'year': newBike.year,
            'status': '1',
          }));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      _activeBike = Bike(
        brand: newBike.brand,
        model: newBike.model,
        number: newBike.number,
        year: newBike.year,
        id: extractedData['Data']['bike_id'],
      );
      _items.add(
        Bike(
          brand: newBike.brand,
          model: newBike.model,
          number: newBike.number,
          year: newBike.year,
          id: extractedData['Data']['bike_id'],
        ),
      );
    } else {
      final response = await http.post(url,
          body: json.encode({
            'make': newBike.brand,
            'model': newBike.model,
            'bike_reg': newBike.number,
            'year': newBike.year,
            'status': '0',
          }));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      _items.add(
        Bike(
          brand: newBike.brand,
          model: newBike.model,
          number: newBike.number,
          year: newBike.year,
          id: extractedData['Data']['bike_id'],
        ),
      );
    }
    notifyListeners();
  }

  Future<void> updateBike(
      {String id,
      String brand,
      String model,
      String year,
      String number}) async {
    final url = 'http://stage.protto.in/api/shivangi/editbike.php/$id';
    await http.patch(url,
        body: json.encode({
          'year': year,
          'bike_reg': number,
          'make': brand,
          'model': model,
        }));
    final bikeIndex = _items.indexWhere((bike) => bike.id == id);
    var bike =
        Bike(brand: brand, id: id, model: model, number: number, year: year);
    if (bikeIndex >= 0) {
      _items[bikeIndex] = bike;
    }
    notifyListeners();
  }

  Future<void> deleteBike(String id) async {
    final url = 'http://stage.protto.in/api/shivangi/deletebike.php/$id';
    await http.delete(url);
    if (activeBike != null) {
      if (activeBike.id == id) {
        _activeBike = null;
        notifyListeners();
      }
    }
    _items.removeWhere((bike) => bike.id == id);
    notifyListeners();
  }

  Future<void> changeActive(Bike bike) async {
    if (_activeBike != null && bike.id != _activeBike.id) {
      var id1 = bike.id;
      var id2 = activeBike.id;
      const url = 'http://stage.protto.in/api/prina/flipstatus.php';
      await http.patch(url,
          body: json.encode({
            'bikeid': id1,
            'bikeid2': id2,
          }));
      _activeBike = bike;
      notifyListeners();
    } else if (_activeBike == null) {
      var id = bike.id;
      const url = 'http://stage.protto.in/api/shivangi/setstatus.php';
      await http.patch(url,
          body: json.encode({
            'bikeid': id,
          }));
      _activeBike = bike;
      notifyListeners();
    } else if (bike.id == _activeBike.id) {
      var id = bike.id;
      const url = 'http://stage.protto.in/api/shivangi/setstatus.php';
      final response = await http.patch(url,
          body: json.encode({
            'bikeid': id,
          }));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] == '0') {
        _activeBike = null;
      } else {
        _activeBike = bike;
      }
      notifyListeners();
    }
  }

  Future<void> getRgPrice(String brand, String model) async {
    final url =
        'http://stage.protto.in/api/shivangi/rgservice.php/?brand=$brand&model=$model';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    _proDry = extractedData['data'][0]['offer'];
    _proWet = extractedData['data'][1]['offer'];
    notifyListeners();
  }

  void logout() async {
    _items.clear();
    _brands.clear();
    _models.clear();
    _activeBike = null;
    _proDry = null;
    _proWet = null;
    notifyListeners();
  }
}
