import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import './bikes.dart';

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
  final String approveJobs;
  final String total;
  final String paid;
  final String ssName;

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
    @required this.approveJobs,
    @required this.total,
    @required this.paid,
    @required this.ssName,
    this.make,
    this.model,
    this.bikeNumber,
    this.bikeYear,
    this.status,
  });
}

class Jobs with ChangeNotifier {
  final String id;
  final String bookingId;
  final String name;
  final String cost;
  final String approved;

  Jobs({
    @required this.id,
    @required this.bookingId,
    @required this.name,
    @required this.cost,
    @required this.approved,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<dynamic> _services;
  List<Jobs> _jobs;

  final String userId;

  Orders(this.userId, this._items);

  List<OrderItem> get items {
    return [..._items];
  }

  List<Jobs> get jobs {
    return [..._jobs];
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
    print(userId);
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
          ssName: extractedData1['data'][i]['ss_name'],
          approveJobs: extractedData1['data'][i]['job_approve'],
          total: extractedData1['data'][i]['total'],
          paid: extractedData1['data'][i]['paid'],
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

  Future<OrderItem> fetchbooking(String bookingId, OrderItem order) async {
    final url =
        'http://stage.protto.in/api/shivangi/fetchbooking.php?booking_id=$bookingId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    return OrderItem(
      id: extractedData['data']['id'],
      bookingId: extractedData['data']['booking_id'],
      address: extractedData['data']['address'],
      approveJobs: extractedData['data']['job_approve'],
      bikeid: extractedData['data']['bike_id'],
      date: extractedData['data']['date'],
      deliveryType: extractedData['data']['delivery_type'],
      flat: extractedData['data']['flat'],
      landmark: extractedData['data']['landmark'],
      paid: extractedData['data']['paid'],
      rideable: extractedData['data']['rideable'],
      serviceType: extractedData['data']['service_type'],
      ssName: extractedData['data']['ss_name'],
      time: extractedData['data']['timestamp'],
      total: extractedData['data']['total'],
      bikeNumber: order.bikeNumber,
      bikeYear: order.bikeYear,
      make: order.make,
      model: order.model,
      status: extractedData['data']['status'],
    );
  }

  Future<void> addOrder(
      OrderItem order, double prottoBucks, Bike activeBike) async {
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
        'total': order.total,
        'paid': '0',
        'date': order.date,
        'timestamp': order.time,
        'delivery_type': order.deliveryType,
        'make': activeBike.brand,
        'model': activeBike.model,
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
        ssName: order.ssName,
        rideable: order.rideable,
        status: order.status,
        total: order.total,
        paid: order.paid,
        approveJobs: order.approveJobs,
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
        ssName: order.ssName,
        total: order.total,
        paid: order.paid,
        approveJobs: order.approveJobs,
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

  Future<void> getjobs(String bookingId) async {
    final url =
        'http://stage.protto.in/api/shivangi/getjobs.php?booking_id=$bookingId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['count'] != '0') {
      var data = [];
      for (int i = 0; i < int.parse(extractedData['count']); i++) {
        data.add(
          Jobs(
            id: extractedData['jobs'][i]['job_id'],
            bookingId: bookingId,
            name: extractedData['jobs'][i]['part_name'],
            cost: extractedData['jobs'][i]['part_cost'],
            approved: extractedData['jobs'][i]['approved'],
          ),
        );
      }
      _jobs = List<Jobs>.from(data);
      notifyListeners();
    }
  }

  Future<void> jobapprove(
      String bookingId, List<String> data, String total, String paid) async {
    const url1 = 'http://stage.protto.in/api/hitesh/setjobapprove.php';
    await http.patch(url1,
        body: json
            .encode({'booking_id': bookingId, 'total': total, 'paid': paid}));
    const url2 = 'http://stage.protto.in/api/shivangi/setapproved.php';
    await http.patch(url2,
        body: json.encode({
          'data': data,
        }));
    var index = _items.indexWhere((order) => order.bookingId == bookingId);
    var item = _items[index];
    _items[index] = OrderItem(
      id: item.id,
      bikeid: item.bikeid,
      address: item.address,
      approveJobs: '1',
      bookingId: item.bookingId,
      date: item.date,
      deliveryType: item.deliveryType,
      flat: item.flat,
      total: total,
      paid: paid,
      landmark: item.landmark,
      rideable: item.rideable,
      serviceType: item.serviceType,
      ssName: item.ssName,
      time: item.time,
      bikeNumber: item.bikeNumber,
      bikeYear: item.bikeYear,
      make: item.make,
      model: item.model,
      status: item.status,
    );
    notifyListeners();
  }

  Future<String> verifyotp(String bookingId, String otp) async {
    const url = 'http://stage.protto.in/api/hitesh/otpapprove.php';
    final response = await http.patch(url,
        body: json.encode({
          'booking_id': bookingId,
          'otp': otp,
        }));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['message'] == 'otp already approved') {
      return 'You have already verified otp!';
    }
    if (extractedData['message'] == 'Invalid OTP') {
      return 'Incorrect otp';
    }
    if (extractedData['message'] == 'otp approved') {
      return 'Otp verification successful!';
    }
    return 'some error';
  }

  void logout() async {
    _items.clear();
    _services.clear();
    _jobs.clear();
    notifyListeners();
  }
}
