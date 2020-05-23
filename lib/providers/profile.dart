import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String number;

  Profile({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.number,
  });
}

class UserProfile with ChangeNotifier {
  Profile _item = Profile(
    id: DateTime.now().toString(),
    firstName: 'Kunjan',
    lastName: 'Hirpara',
    email: 'jamesondunn@gmail.com',
    number: '+91 7990653359',
  );

  Profile get item {
    return _item;
  }

  void editProfile(Profile profile) {
    _item = profile;
    notifyListeners();
  }
}
