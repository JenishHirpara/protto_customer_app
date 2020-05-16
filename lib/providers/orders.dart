import 'package:flutter/material.dart';

class ActiveOrderItem with ChangeNotifier {
  final String name;
  final String id;
  final DateTime date;
  final String time;
  final String address;
  final String number;
  String status;

  ActiveOrderItem({
    @required this.name,
    @required this.id,
    @required this.date,
    @required this.time,
    @required this.address,
    @required this.number,
    this.status,
  });
}

class PastOrderItem with ChangeNotifier {
  final String name;
  final String id;
  final DateTime date;
  String status;

  PastOrderItem({
    @required this.name,
    @required this.id,
    @required this.date,
    this.status,
  });
}

class ActiveOrders with ChangeNotifier {
  List<ActiveOrderItem> _items = [
    ActiveOrderItem(
      name: 'Yamaha FZ',
      id: '20191004122734',
      date: DateTime.now(),
      time: '9am - 11am',
      address: '701 Landmark, MG Road, Vile Parle (E)',
      number: 'MH 02 KG 0904',
      status: 'Picked Up',
    ),
  ];

  List<ActiveOrderItem> get items {
    return [..._items];
  }
}

class PastOrders with ChangeNotifier {
  List<PastOrderItem> _items = [
    PastOrderItem(
      name: 'Yamaha FZ',
      id: '20191004122734',
      date: DateTime.now(),
      status: 'Delivered',
    ),
    PastOrderItem(
      name: 'Yamaha FZ',
      id: '20191004122734',
      date: DateTime.now(),
      status: 'Delivered',
    ),
    PastOrderItem(
      name: 'Yamaha FZ',
      id: '20191004122734',
      date: DateTime.now(),
      status: 'Delivered',
    ),
  ];

  List<PastOrderItem> get items {
    return [..._items];
  }
}
