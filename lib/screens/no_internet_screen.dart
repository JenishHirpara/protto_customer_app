import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  final Function retry;

  NoInternetScreen(this.retry);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: mediaQuery.size.height * 0.1),
            Center(
              child: Image.asset(
                'assets/images/no_internet.png',
                fit: BoxFit.cover,
                height: mediaQuery.size.height * 0.3,
                width: mediaQuery.size.width * 0.8,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Not Connected To Internet',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Please connect your phone to active internet connection',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  color: Color.fromRGBO(112, 112, 112, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Thank You!',
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Retry',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    color: Colors.white,
                  ),
                ),
                onPressed: retry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
