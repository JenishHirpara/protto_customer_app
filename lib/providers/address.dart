import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Address with ChangeNotifier {
  final String id;
  final String flat;
  final String address;
  final String latitude;
  final String longitude;
  final String landmark;
  final String saveas;
  final String active;

  Address({
    @required this.id,
    @required this.flat,
    @required this.address,
    @required this.latitude,
    @required this.longitude,
    @required this.landmark,
    @required this.saveas,
    @required this.active,
  });
}

class Addresses with ChangeNotifier {
  List<Address> _items = [];
  List<String> _pincodes = [];

  final String userId;

  Addresses(this.userId, this._items);

  List<Address> get items {
    return [..._items];
  }

  List<String> get pincodes {
    return [..._pincodes];
  }

  Future<void> fetchAndSetAddresses() async {
    final url = 'http://stage.protto.in/api/hitesh/address/$userId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Address> data = [];
    for (int i = 0; i < int.parse(extractedData['count']); i++) {
      data.insert(
        i,
        Address(
          id: extractedData['addresses'][i]['address_id'],
          flat: extractedData['addresses'][i]['flat'],
          address: extractedData['addresses'][i]['address'],
          landmark: extractedData['addresses'][i]['landmark'],
          saveas: extractedData['addresses'][i]['category'],
          active: extractedData['addresses'][i]['active'],
          latitude: extractedData['addresses'][i]['lat'],
          longitude: extractedData['addresses'][i]['lon'],
        ),
      );
      _items = data;
    }
    notifyListeners();
  }

  Future<void> getpin() async {
    const url = 'http://api.protto.in/targetpin.php';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    _pincodes = List<String>.from(extractedData['pincodes']);
    notifyListeners();
  }

  Future<String> addAddress(Address newAddress) async {
    final url = 'http://stage.protto.in/api/shivangi/addresses.php/$userId';
    var landmark = newAddress.landmark.replaceAll("'", "");
    var saveas = newAddress.saveas.replaceAll("'", "");
    var address = newAddress.address.replaceAll("'", "");
    var flat = newAddress.flat.replaceAll("'", "");
    final response = await http.post(url,
        body: json.encode({
          'category': saveas,
          'address': address,
          'flat': flat,
          'lat': newAddress.latitude,
          'lon': newAddress.longitude,
          'landmark': landmark
        }));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    _items.insert(
      0,
      Address(
        saveas: saveas,
        flat: flat,
        address: address,
        latitude: newAddress.latitude,
        longitude: newAddress.longitude,
        id: extractedData['address_id'],
        landmark: landmark,
        active: "0",
      ),
    );
    notifyListeners();
    return extractedData['address_id'];
  }

  Future<void> editAddress(String id, Address newAddress) async {
    final url = 'http://stage.protto.in/api/prina/editaddress.php/$id';
    await http.patch(url,
        body: json.encode({
          'address': newAddress.address,
          'flat': newAddress.flat,
          'latitude': newAddress.latitude,
          'longitude': newAddress.longitude,
        }));
    final addressIndex = _items.indexWhere((address) => address.id == id);
    if (addressIndex >= 0) {
      _items[addressIndex] = newAddress;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteAddress(String id) async {
    final url = 'http://stage.protto.in/api/prina/deleteaddress.php/$id';
    await http.delete(url);
    _items.removeWhere((address) => address.id == id);
    notifyListeners();
  }

  void logout() async {
    _items.clear();
    notifyListeners();
  }
}
