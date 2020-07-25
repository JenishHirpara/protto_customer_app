import 'package:flutter/material.dart';

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Internet Connection Failed!',
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Theme.of(context).primaryColor,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        'Please connect your phone to active internet connection to successfully proceed.',
        style: TextStyle(
          fontFamily: 'SourceSansPro',
          color: Color.fromRGBO(112, 112, 112, 1),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Okay'),
        ),
      ],
    );
  }
}
