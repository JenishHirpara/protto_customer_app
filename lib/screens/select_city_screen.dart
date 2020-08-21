import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './navigationBarScreen.dart';
import '../providers/profile.dart';

class SelectCityScreen extends StatefulWidget {
  final String city;
  final int time;

  SelectCityScreen(this.city, this.time);

  @override
  _SelectCityScreenState createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  var _isInit = true;
  var _selectedCity;

  PageRouteBuilder pageRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NavigationBarScreen();
      },
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
  }

  void _save(String selectedCity) async {
    Provider.of<UserProfile>(context, listen: false).setCity(selectedCity);
    if (widget.time == 1) {
      await Provider.of<UserProfile>(context, listen: false)
          .setProfile(selectedCity);
      Navigator.of(context).pushReplacement(pageRouteBuilder());
    } else {
      await Provider.of<UserProfile>(context, listen: false)
          .setCityProfile(selectedCity);
      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _selectedCity = widget.city;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: Image.asset(
                'assets/images/protto-logo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Select your City to Proceed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Color(0xff403A35),
                ),
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.05,
            ),
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: _selectedCity == 'Mumbai'
                              ? Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)
                              : null,
                        ),
                        child: Image.asset(
                          'assets/images/Mumbai.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedCity = 'Mumbai';
                        });
                      },
                    ),
                    Text(
                      'Mumbai',
                      style: TextStyle(
                        fontFamily: 'SourceSansProSB',
                        fontSize: 16,
                        color: Color(0xff403A35),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: _selectedCity == 'Bangalore'
                              ? Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)
                              : null,
                        ),
                        child: Image.asset(
                          'assets/images/Bangalore.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedCity = 'Bangalore';
                        });
                      },
                    ),
                    Text(
                      'Bangalore',
                      style: TextStyle(
                        fontFamily: 'SourceSansProSB',
                        fontSize: 16,
                        color: Color(0xff403A35),
                      ),
                    ),
                  ],
                ),
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                onPressed: () => _save(_selectedCity),
                child: Text(
                  'Select and Proceed',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
