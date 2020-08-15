import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:intl/intl.dart';
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
  String _signupOtp;
  String _name;
  String _email;
  String _number;

  Profile get item {
    return _item;
  }

  String get number {
    return _number;
  }

  String get name {
    return _name;
  }

  String get email {
    return _email;
  }

  Profile get dummyItem {
    return _dummyItem;
  }

  String get signupOtp {
    return _signupOtp;
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

  Future<void> getOtp(String name, String number, String email) async {
    var url =
        'http://api.protto.in/editotp.php?cid=${_item.id}&mobile=$number&email=$email';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    final response = await http
        .get(url, headers: <String, String>{'Authorization': basicAuth});
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['message'] ==
        'User with that mobile number already exists') {
      throw HttpException('Another user has the same mobile number');
    } else if (extractedData['message'] ==
        'User with that email already exists') {
      throw HttpException('Another user has the same email');
    }
    if (extractedData['message'] == 'User already exists') {
      throw HttpException(
          'Provided email and mobile are already in use by another User');
    }
    _signupOtp = extractedData['otp'];
    _name = name;
    _number = number;
    _email = email;
    //notifyListeners();
  }

  Future<void> getProfile(String number) async {
    var url = 'http://api.protto.in/data.php/$number';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    final response = await http
        .get(url, headers: <String, String>{'Authorization': basicAuth});
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['message'] == 'User does not exist') {
      _signupOtp = extractedData['otp'];
      _number = number;
      notifyListeners();
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
    const url = 'http://api.protto.in/register.php';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    var response;
    if (referal == '') {
      response = await http.post(url,
          body: json.encode({
            'name': name,
            'email': email,
            'mobile': number,
            'otp': signupOtp,
          }),
          headers: <String, String>{'Authorization': basicAuth});
    } else {
      response = await http.post(url,
          body: json.encode({
            'name': name,
            'email': email,
            'mobile': number,
            'referal': referal,
            'otp': signupOtp,
          }),
          headers: <String, String>{'Authorization': basicAuth});
    }
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData['message'] == 'User already Exists') {
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

  Future<void> editProfile() async {
    final url = 'http://api.protto.in/edit.php/${_item.id}';
    final storage = new FlutterSecureStorage();
    String key = await storage.read(key: 'key');
    String value = await storage.read(key: 'value');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
    await http.patch(url,
        body: json.encode({
          'name': _name,
          'email': _email,
          'mobile': _number,
        }),
        headers: <String, String>{'Authorization': basicAuth});
    var id = _item.id;
    var prottoBuck = _item.prottoBucks;
    _item = Profile(
      id: id,
      email: _email,
      name: _name,
      number: _number,
      otp: _signupOtp,
      prottoBucks: prottoBuck,
    );
    //notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final user = json.encode({
      'token': extractedUserData['token'],
      'number': _number,
    });
    prefs.setString('userData', user);
  }

  String calcHmac(String key, String value) {
    var key1 = utf8.encode(key);
    var value1 = utf8.encode(value);
    var hmacSha256 = new Hmac(sha256, key1);
    var digest = hmacSha256.convert(value1);
    return digest.toString();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    try {
      var url =
          'http://api.protto.in/loginwithoutotp.php?mobile=${extractedUserData['number']}';
      final storage = new FlutterSecureStorage();
      String key = await storage.read(key: 'key');
      String value = await storage.read(key: 'value');
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$value'));
      final response = await http
          .get(url, headers: <String, String>{'Authorization': basicAuth});
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
      _number = extractedUserData['number'];
      notifyListeners();
      // print(deviceToken);
      // var encodedToken = Uri.encodeComponent(deviceToken);
      // var url2 =
      //     'https://sns.ap-south-1.amazonaws.com/?Action=CreatePlatformEndpoint&PlatformApplicationArn=arn:aws:sns:ap-south-1:212753112725:app/GCM/Protto&Token=$deviceToken';
      // var datetime = DateFormat('yyyyMMdd').format(DateTime.now().toUtc());
      // var datetime2 = DateFormat('HHmmss').format(DateTime.now().toUtc());
      // var canonicalRequest =
      //     'GET\n/\nAction=CreatePlatformEndpoint&PlatformApplicationArn=arn%3Aaws%3Asns%3Aap-south-1%3A212753112725%3Aapp%2FGCM%2FProtto&Token=$encodedToken&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIATDCIS32KUIQYQJI2%2F$datetime%2Fap-south-1%2Fsns%2Faws4_request&X-Amz-Date=${datetime}T${datetime2}Z&X-Amz-SignedHeaders=accept%3Bhost%3Bx-amz-content-sha256%3Bx-amz-date\naccept:application/json\nhost:sns.ap-south-1.amazonaws.com\nx-amz-content-sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\nx-amz-date:${datetime}T${datetime2}Z\n\naccept;host;x-amz-content-sha256;x-amz-date\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';
      // var canonicalString = sha256.convert(utf8.encode(canonicalRequest));
      // var stringtosign =
      //     'AWS4-HMAC-SHA256\n${datetime}T${datetime2}Z\n$datetime/ap-south-1/sns/aws4_request\n$canonicalString';
      // var signature = calcHmac(
      //     calcHmac(
      //         calcHmac(
      //             calcHmac("AWS4" + "bizA5nlN7efa2qSy8/HxCocppPyh8VFngz2oUYVj",
      //                 '$datetime'),
      //             "ap-south-1"),
      //         "sns"),
      //     "aws4_request");
      // var finalSignature = calcHmac(signature, stringtosign);
      // final response2 = await http.get(url2, headers: <String, String>{
      //   'Accept': 'application/json',
      //   'x-amz-content-sha256':
      //       'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      //   'Authorization':
      //       'AWS4-HMAC-SHA256 Credential=AKIATDCIS32KUIQYQJI2/$datetime/ap-south-1/sns/aws4_request, SignedHeaders=accept;host;x-amz-content-sha256;x-amz-date, Signature=$finalSignature',
      //   'x-amz-date': '${datetime}T${datetime2}Z',
      // });
      // final extractedData2 = json.decode(response2.body);
      // print(finalSignature);
      // print(extractedData2);
      return true;
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _item = null;
    _dummyItem = null;
    _email = null;
    _name = null;
    _number = null;
    _signupOtp = null;
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
