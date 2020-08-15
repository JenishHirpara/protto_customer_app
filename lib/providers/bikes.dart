import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './cart_item.dart';

class Bike with ChangeNotifier {
  final String id;
  final String brand;
  final String model;
  final String year;
  final String number;
  final String active;

  Bike({
    @required this.id,
    @required this.brand,
    @required this.model,
    @required this.year,
    @required this.number,
    @required this.active,
  });
}

class Bikes with ChangeNotifier {
  List<Bike> _items = [];
  List<String> _brands = [];
  List<String> _models = [];
  Bike _activeBike;
  String _proDry;
  String _proWet;
  bool _loadServices = true;

  final String userId;

  Bikes(this.userId, this._items);

  List<Bike> get items {
    return [..._items];
  }

  List<String> get brands {
    return [..._brands];
  }

  bool get loadServices {
    return _loadServices;
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
    final url = 'http://api.protto.in/bike/$userId';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    final response = await http
        .get(url, headers: <String, String>{'Authorization': basicAuth});
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
          active: extractedData['bikes'][i]['active'],
        ),
      );
      if (extractedData['bikes'][i]['status'].toString() == '1') {
        _activeBike = Bike(
          id: extractedData['bikes'][i]['bike_id'],
          brand: extractedData['bikes'][i]['make'],
          model: extractedData['bikes'][i]['model'],
          number: extractedData['bikes'][i]['bike_reg'],
          year: extractedData['bikes'][i]['year'],
          active: extractedData['bikes'][i]['active'],
        );
        notifyListeners();
      }
    }
    _items = data;
    if (_activeBike == null) {
      _loadServices = false;
    }
    notifyListeners();
  }

  Future<void> fetchAllBrands() async {
    const url = 'http://api.protto.in/brand.php';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    final response = await http
        .get(url, headers: <String, String>{'Authorization': basicAuth});
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<String> brands = List<String>.from(extractedData['data']);
    _brands = brands;
    notifyListeners();
  }

  Future<void> fetchAllModels(String brand) async {
    final url = 'http://api.protto.in/models.php/$brand';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    final response = await http
        .get(url, headers: <String, String>{'Authorization': basicAuth});
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<String> models = [];
    models = List<String>.from(extractedData['data']);
    _models = models;
    notifyListeners();
  }

  Future<void> addBike(Bike newBike) async {
    final url = 'http://api.protto.in/addbike.php/$userId';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    if (_items.length == 0 || activeBike == null) {
      final response = await http.post(url,
          body: json.encode({
            'make': newBike.brand,
            'model': newBike.model,
            'bike_reg': newBike.number,
            'year': newBike.year,
            'status': '1',
          }),
          headers: <String, String>{'Authorization': basicAuth});
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      _activeBike = Bike(
        brand: newBike.brand,
        model: newBike.model,
        number: newBike.number,
        year: newBike.year,
        active: "0",
        id: extractedData['Data']['bike_id'],
      );
      _loadServices = true;
      _items.add(
        Bike(
          brand: newBike.brand,
          model: newBike.model,
          number: newBike.number,
          year: newBike.year,
          active: "0",
          id: extractedData['Data']['bike_id'],
        ),
      );
      notifyListeners();
    } else {
      final response = await http.post(url,
          body: json.encode({
            'make': newBike.brand,
            'model': newBike.model,
            'bike_reg': newBike.number,
            'year': newBike.year,
            'status': '0',
          }),
          headers: <String, String>{'Authorization': basicAuth});
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      _items.add(
        Bike(
          brand: newBike.brand,
          model: newBike.model,
          number: newBike.number,
          year: newBike.year,
          active: "0",
          id: extractedData['Data']['bike_id'],
        ),
      );
      notifyListeners();
    }
  }

  void startLoad() {
    _loadServices = true;
    notifyListeners();
  }

  void endLoad() {
    _loadServices = false;
    notifyListeners();
  }

  Future<void> updateBike({
    String id,
    String brand,
    String model,
    String year,
    String number,
    String active,
  }) async {
    final url = 'http://api.protto.in/editbike.php/$id';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    await http.patch(url,
        body: json.encode({
          'year': year,
          'bike_reg': number,
          'make': brand,
          'model': model,
        }),
        headers: <String, String>{'Authorization': basicAuth});
    final bikeIndex = _items.indexWhere((bike) => bike.id == id);
    var bike = Bike(
      brand: brand,
      id: id,
      model: model,
      number: number,
      year: year,
      active: active,
    );
    if (bikeIndex >= 0) {
      _items[bikeIndex] = bike;
    }
    notifyListeners();
  }

  Future<void> deleteBike(String id) async {
    final url = 'http://api.protto.in/deletebike.php/$id';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    await http
        .delete(url, headers: <String, String>{'Authorization': basicAuth});
    if (activeBike != null) {
      if (activeBike.id == id) {
        _activeBike = null;
        notifyListeners();
      }
    }
    _items.removeWhere((bike) => bike.id == id);
    notifyListeners();
  }

  Future<void> changeActive(Bike bike, Cart cart) async {
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    if (_activeBike != null && bike.id != _activeBike.id) {
      var id1 = bike.id;
      var id2 = activeBike.id;
      const url = 'http://api.protto.in/flipstatus.php';
      await http.patch(url,
          body: json.encode({
            'bikeid': id1,
            'bikeid2': id2,
          }),
          headers: <String, String>{'Authorization': basicAuth});
      _loadServices = true;
      _activeBike = bike;
    } else if (_activeBike == null) {
      var id = bike.id;
      const url = 'http://api.protto.in/setstatus.php';
      await http.patch(url,
          body: json.encode({
            'bikeid': id,
          }),
          headers: <String, String>{'Authorization': basicAuth});
      _loadServices = true;
      _activeBike = bike;
    } else if (bike.id == _activeBike.id) {
      var id = bike.id;
      const url = 'http://api.protto.in/setstatus.php';
      final response = await http.patch(url,
          body: json.encode({
            'bikeid': id,
          }),
          headers: <String, String>{'Authorization': basicAuth});
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] == '0') {
        _loadServices = false;
        _activeBike = null;
      } else {
        _loadServices = true;
        _activeBike = bike;
      }
    }
    cart.resetCart();
    notifyListeners();
  }

  Future<void> getRgPrice(String brand, String model) async {
    final url = 'http://api.protto.in/rgservice.php?brand=$brand&model=$model';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    final response = await http
        .get(url, headers: <String, String>{'Authorization': basicAuth});
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
    _loadServices = true;
    _proDry = null;
    _proWet = null;
    notifyListeners();
  }
}
