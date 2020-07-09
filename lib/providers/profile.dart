import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';
import '../screens/dashboard_screen.dart';

class Profile with ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final String number;
  final String prottoBucks;
  final String otp;

  Profile({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.number,
    @required this.prottoBucks,
    @required this.otp,
  });
}

class UserProfile with ChangeNotifier {
  Profile _item;
  String _token;
  Profile _dummyItem;

  Profile get item {
    return _item;
  }

  Profile get dummyItem {
    return _dummyItem;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> getProfile(String number) async {
    var url = 'http://stage.protto.in/api/prina/data.php/$number';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['message'] == 'User does not exist') {
      throw HttpException('User does not exist!');
    }
    _dummyItem = Profile(
      id: extractedData['Data']['cid'],
      name: extractedData['Data']['name'],
      email: extractedData['Data']['email'],
      number: extractedData['Data']['mobile'],
      prottoBucks: extractedData['Data']['protto_bucks'],
      otp: extractedData['Data']['otp'],
    );
    notifyListeners();
    DashBoardScreen.isSignUp = false;
  }

  Future<void> setProfile() async {
    _item = _dummyItem;
    var rng = new Random();
    _token = '${rng.nextInt(90000000) + 10000000}';
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final user = json.encode({
      'token': _token,
      'number': _dummyItem.number,
    });
    prefs.setString('userData', user);
  }

  Future<void> newProfile(
      String name, String email, String number, String referal) async {
    const url = 'http://stage.protto.in/api/prina/register.php';
    var response;
    if (referal == null) {
      response = await http.post(url,
          body: json.encode({
            'name': name,
            'email': email,
            'mobile': number,
          }));
    } else {
      response = await http.post(url,
          body: json.encode({
            'name': name,
            'email': email,
            'mobile': number,
            'referal': referal,
          }));
    }
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['message'] == 'User already exists.') {
      throw HttpException('User already exists!');
    }
    if (extractedData['message'] == 'Invalid referal') {
      throw HttpException('Invalid referal');
    }
    _dummyItem = Profile(
      id: extractedData['Data']['cid'],
      name: extractedData['Data']['name'],
      email: extractedData['Data']['email'],
      number: extractedData['Data']['mobile'],
      prottoBucks: extractedData['Data']['protto_bucks'],
      otp: extractedData['Data']['otp'],
    );
    notifyListeners();
    DashBoardScreen.isSignUp = true;
  }

  void editProfile(Profile profile) {
    _item = profile;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    var url =
        'http://stage.protto.in/api/hitesh/loginwithoutotp.php?mobile=${extractedUserData['number']}';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    _item = Profile(
      id: extractedData['data']['cid'],
      name: extractedData['data']['name'],
      email: extractedData['data']['email'],
      number: extractedData['data']['mobile'],
      prottoBucks: extractedData['data']['protto_bucks'],
      otp: extractedData['data']['otp'],
    );
    _token = extractedUserData['token'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _item = null;
    _dummyItem = null;
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
