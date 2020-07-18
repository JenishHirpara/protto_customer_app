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
  final String addressId;
  final String flat;
  final String address;
  final String landmark;
  final String deliveryType;
  final String approveJobs;
  final String total;
  final String paid;
  final String ssName;
  final String specialRequest;

  OrderItem({
    @required this.id,
    @required this.bookingId,
    @required this.rideable,
    @required this.serviceType,
    @required this.time,
    @required this.date,
    @required this.bikeid,
    @required this.flat,
    @required this.addressId,
    @required this.address,
    @required this.deliveryType,
    @required this.landmark,
    @required this.approveJobs,
    @required this.total,
    @required this.paid,
    @required this.ssName,
    @required this.specialRequest,
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

  List<dynamic> _services = [];
  List<Jobs> _jobs = [];
  List<String> _preImages = [];
  List<String> _postImages = [];
  String _preOdometerReading;
  String _postOdometerReading;
  String _preFuelLevel;
  String _postFuelLevel;

  final String userId;

  Orders(this.userId, this._items);

  List<OrderItem> get items {
    return [..._items];
  }

  String get preOdometerReading {
    return _preOdometerReading;
  }

  String get postOdometerReading {
    return _postOdometerReading;
  }

  String get preFuelLevel {
    return _preFuelLevel;
  }

  String get postFuelLevel {
    return _postFuelLevel;
  }

  List<String> get preImages {
    return [..._preImages];
  }

  List<String> get postImages {
    return [..._postImages];
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
          addressId: extractedData1['data'][i]['address_id'],
          address: extractedData1['data'][i]['address'],
          flat: extractedData1['data'][i]['flat'],
          landmark: extractedData1['data'][i]['landmark'],
          ssName: extractedData1['data'][i]['ss_name'],
          approveJobs: extractedData1['data'][i]['job_approve'],
          total: extractedData1['data'][i]['total'],
          specialRequest: extractedData1['data'][i]['special_request'],
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
      addressId: extractedData['data']['address_id'],
      flat: extractedData['data']['flat'],
      landmark: extractedData['data']['landmark'],
      specialRequest: extractedData['data']['special_request'],
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

  Future<String> addOrder(
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
        'address_id': order.addressId,
        'total': order.total,
        'paid': '0.0',
        'date': order.date,
        'timestamp': order.time,
        'special_request': order.specialRequest,
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
        addressId: order.addressId,
        address: order.address,
        bikeid: order.bikeid,
        date: order.date,
        deliveryType: order.deliveryType,
        flat: order.flat,
        landmark: order.landmark,
        time: order.time,
        serviceType: order.serviceType,
        specialRequest: order.specialRequest,
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
    return extractedData['id'];
  }

  OrderItem findById(String id) {
    var order = _items.firstWhere((orders) => orders.id == id);
    return order;
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
        addressId: order.addressId,
        flat: order.flat,
        landmark: order.landmark,
        rideable: order.rideable,
        serviceType: order.serviceType,
        ssName: order.ssName,
        total: order.total,
        paid: order.paid,
        approveJobs: order.approveJobs,
        specialRequest: order.specialRequest,
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
      addressId: item.addressId,
      flat: item.flat,
      total: total,
      paid: paid,
      landmark: item.landmark,
      rideable: item.rideable,
      specialRequest: item.specialRequest,
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

  Future<String> verifyotp(String bookingId, String otp, String status) async {
    const url = 'http://stage.protto.in/api/hitesh/otpapprove.php';
    final response = await http.patch(url,
        body: json.encode({
          'booking_id': bookingId,
          'otp': otp,
          'status': status,
        }));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['message'] == 'otp cannot be approved right now') {
      return extractedData['message'];
    }
    if (extractedData['message'] == 'Invalid OTP') {
      return 'Incorrect otp';
    }
    if (extractedData['message'] == 'otp approved') {
      var index = _items.indexWhere((order) => order.bookingId == bookingId);
      var item = _items.firstWhere((order) => order.bookingId == bookingId);
      _items[index] = OrderItem(
        id: item.id,
        bookingId: bookingId,
        rideable: item.rideable,
        serviceType: item.serviceType,
        time: item.time,
        date: item.date,
        bikeid: item.bikeid,
        addressId: item.addressId,
        flat: item.flat,
        address: item.address,
        deliveryType: item.deliveryType,
        landmark: item.landmark,
        approveJobs: item.approveJobs,
        total: item.total,
        paid: item.paid,
        ssName: item.ssName,
        specialRequest: item.specialRequest,
        status: '${int.parse(status) + 1}',
      );
      notifyListeners();
      return 'Otp verification successful!';
    }
    return 'some error';
  }

  Future<void> getpreimages(String bookingId) async {
    final url =
        'http://stage.protto.in/api/shivangi/getpreserviceinspection.php?booking_id=$bookingId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['data'] == null) {
      _preImages.clear();
      _preOdometerReading = null;
      _preFuelLevel = null;
      return;
    }
    _preImages.clear();
    _preImages.add(extractedData['data']['front_pic']);
    _preImages.add(extractedData['data']['left_pic']);
    _preImages.add(extractedData['data']['rear_pic']);
    _preImages.add(extractedData['data']['right_pic']);
    _preImages.add(extractedData['data']['dashboard_pic']);
    _preImages.add(extractedData['data']['number_pic']);
    _preOdometerReading = extractedData['data']['odometer_reading'];
    _preFuelLevel = extractedData['data']['fuel_level'];
    notifyListeners();
  }

  Future<void> getpostimages(String bookingId) async {
    final url =
        'http://stage.protto.in/api/hitesh/getdeliveryinspection.php?booking_id=$bookingId';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['data'] == null) {
      _postImages.clear();
      _postOdometerReading = null;
      _postFuelLevel = null;
      return;
    }
    _postImages.clear();
    _postImages.add(extractedData['data']['front_pic']);
    _postImages.add(extractedData['data']['left_pic']);
    _postImages.add(extractedData['data']['rear_pic']);
    _postImages.add(extractedData['data']['right_pic']);
    _postImages.add(extractedData['data']['dashboard_pic']);
    _postImages.add(extractedData['data']['number_pic']);
    _postOdometerReading = extractedData['data']['odometer_reading'];
    _postFuelLevel = extractedData['data']['fuel_level'];
    notifyListeners();
  }

  void logout() async {
    _items.clear();
    _services.clear();
    _jobs.clear();
    notifyListeners();
  }
}
