import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final String bookingId;
  final String make;
  final String model;
  final String rideable;
  final String bikeid;
  final String serviceType;
  final String bikeYear;
  final String status;
  final String date;
  final String time;
  final String bikeNumber;
  final String flat;
  final String address;
  final String landmark;
  final String deliveryType;

  OrderItem({
    @required this.id,
    @required this.bookingId,
    @required this.rideable,
    @required this.serviceType,
    @required this.time,
    @required this.date,
    @required this.bikeid,
    @required this.flat,
    @required this.address,
    @required this.deliveryType,
    @required this.landmark,
    this.make,
    this.model,
    this.bikeNumber,
    this.bikeYear,
    this.status,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<dynamic> _services;

  final String userId;

  Orders(this.userId, this._items);

  List<OrderItem> get items {
    return [..._items];
  }

  List<OrderItem> get activeOrders {
    var activeOrders = items.where((order) => order.status != '9').toList();
    return activeOrders;
  }

  List<OrderItem> get pastOrders {
    var pastOrders = items.where((order) => order.status == '9').toList();
    return pastOrders;
  }

  List<dynamic> get services {
    return [..._services];
  }

  Future<void> fetchAndSetOrders() async {
    final url1 =
        'http://stage.protto.in/api/hitesh/getbookings.php?cid=$userId';
    final response1 = await http.get(url1);
    final extractedData1 = json.decode(response1.body) as Map<String, dynamic>;

    List<OrderItem> data = [];

    if (extractedData1['success'] == 'false') {
      return;
    }
    for (int i = 0; i < int.parse(extractedData1['count']); i++) {
      final bikeid = extractedData1['data'][i]['bike_id'];
      final url2 = 'http://stage.protto.in/api/shivangi/getbike.php/$bikeid';
      final response2 = await http.get(url2);
      final extractedData2 =
          json.decode(response2.body) as Map<String, dynamic>;
      data.insert(
        i,
        OrderItem(
          id: extractedData1['data'][i]['id'],
          bookingId: extractedData1['data'][i]['booking_id'],
          rideable: extractedData1['data'][i]['rideable'],
          serviceType: extractedData1['data'][i]['service_type'],
          status: extractedData1['data'][i]['status'],
          address: extractedData1['data'][i]['address'],
          flat: extractedData1['data'][i]['flat'],
          landmark: extractedData1['data'][i]['landmark'],
          date: extractedData1['data'][i]['date'],
          time: extractedData1['data'][i]['timestamp'],
          bikeid: extractedData1['data'][i]['bike_id'],
          deliveryType: extractedData1['data'][i]['delivery_type'],
          bikeNumber: extractedData2['data']['bike_reg'],
          bikeYear: extractedData2['data']['year'],
          make: extractedData2['data']['make'],
          model: extractedData2['data']['model'],
        ),
      );
    }
    _items = data;
    notifyListeners();
  }

  Future<void> addOrder(OrderItem order, double prottoBucks) async {
    final url1 = 'http://stage.protto.in/api/hitesh/updatebucks.php';
    await http.patch(url1,
        body: json.encode({
          'cid': userId,
          'protto_bucks': prottoBucks,
        }));
    final url = 'http://stage.protto.in/api/hitesh/addbookings.php';
    final response = await http.post(
      url,
      body: json.encode({
        'cid': userId,
        'bike_id': order.bikeid,
        'rideable': order.rideable,
        'service_type': order.serviceType,
        'address': order.address,
        'flat': order.flat,
        'landmark': order.landmark,
        'date': order.date,
        'timestamp': order.time,
        'delivery_type': order.deliveryType,
      }),
    );
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final url2 =
        'http://stage.protto.in/api/shivangi/getbike.php/${order.bikeid}';
    print(extractedData['id']);
    print(extractedData['booking_id']);
    final response2 = await http.get(url2);
    final extractedData2 = json.decode(response2.body) as Map<String, dynamic>;
    _items.add(
      OrderItem(
        id: extractedData['id'],
        bookingId: extractedData['booking_id'],
        address: order.address,
        bikeid: order.bikeid,
        date: order.date,
        deliveryType: order.deliveryType,
        flat: order.flat,
        landmark: order.landmark,
        time: order.time,
        serviceType: order.serviceType,
        rideable: order.rideable,
        status: '1',
        bikeNumber: extractedData2['data']['bike_reg'],
        bikeYear: extractedData2['data']['year'],
        make: extractedData2['data']['make'],
        model: extractedData2['data']['model'],
      ),
    );
    notifyListeners();
  }

  Future<void> getservices(String bookingId) async {
    final url =
        'http://stage.protto.in/api/shivangi/getservicetype.php/$bookingId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    _services = extractedData['data'];
    notifyListeners();
  }

  Future<void> editDate(String date, String time, String bookingId) async {
    final url =
        'http://stage.protto.in/api/shivangi/getstatus.php?bookingid=$bookingId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['status'] != '1') {
      throw HttpException('Cannot change the date now');
    }
    final url1 = 'http://stage.protto.in/api/prina/editdate.php';
    await http.patch(url1,
        body: json.encode({
          'booking_id': bookingId,
          'timestamp': time,
          'date': date,
        }));
    var id = _items.indexWhere((order) => order.bookingId == bookingId);
    var order = _items.firstWhere((order) => order.bookingId == bookingId);

    _items.removeAt(id);
    _items.insert(
      id,
      OrderItem(
        id: order.id,
        bookingId: order.bookingId,
        address: order.address,
        bikeid: order.bikeid,
        deliveryType: order.deliveryType,
        flat: order.flat,
        landmark: order.landmark,
        rideable: order.rideable,
        serviceType: order.serviceType,
        bikeNumber: order.bikeNumber,
        bikeYear: order.bikeYear,
        make: order.make,
        model: order.model,
        status: order.status,
        date: date,
        time: time,
      ),
    );
    notifyListeners();
  }
}
