import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import './service_screen.dart';
import '../utils/SizeConfig.dart';
import './new_bike_screen.dart';

Color orangeColor = new Color(0xFFF69C7A);
Color greyColor = new Color(0xFFC2C2C2);

String scheduleService = "Schedule \n" + "Service";
String regularServices = "Regular \n" + "Service";
String tyres = "Tyres \n" + " ";
String washPlusCoat = "Wash + \nCoat";
String customRepairs = "Custom \n" + "Repairs";
String dentingPainting = "Denting &\n" + "Painting";

var bottomNavBarIndex = 0;

class DashBoardScreen extends StatefulWidget {
  static var isSignUp = false;
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Future<void> _showPopUp() {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: Container(
            height: 220,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Thank You for Signing up!!',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.deepOrange,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Use your mobile number to sign in next time. Before we get started, lets add a bike.',
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        color: Color.fromRGBO(100, 100, 100, 1),
                        fontSize: 18),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 120,
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    elevation: 0,
                    child: Text(
                      'Okay',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'SourceSansProSB'),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).push(newBikeRouteBuilder());
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      if (DashBoardScreen.isSignUp) {
        Future.delayed(Duration(milliseconds: 50), _showPopUp);
      }
    }
    _isInit = false;
    DashBoardScreen.isSignUp = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 100,
      child: Column(
        children: <Widget>[
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 36,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        'Services',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 25,
                                      height: SizeConfig.blockSizeVertical * 10,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/gear_with_car.png'),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(pageRouteBuilder(0));
                                    },
                                  ),
                                  Text(
                                    regularServices,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansSB',
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 25,
                                      height: SizeConfig.blockSizeVertical * 10,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/tyres.png'),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(pageRouteBuilder(1));
                                    },
                                  ),
                                  Text(
                                    tyres,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansSB',
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 25,
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/wash_plus_coat.png'))),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(pageRouteBuilder(2));
                                    },
                                  ),
                                  Text(
                                    washPlusCoat,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansSB',
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 25,
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/custom_repairs.png'))),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(pageRouteBuilder(3));
                                    },
                                  ),
                                  Text(
                                    customRepairs,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansSB',
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 25,
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/denting_penting.png'))),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(pageRouteBuilder(4));
                                    },
                                  ),
                                  Text(
                                    dentingPainting,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansSB',
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                  child: Text(
                    'Popular Services',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                swiperWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget swiperWidget() {
    List imagesList = [
      'assets/images/bike_one.jpg',
      'assets/images/bike_two.jpg',
      'assets/images/bike_three.jpg',
    ];

    return Container(
      height: SizeConfig.blockSizeVertical * 40,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            imagesList[index],
            fit: BoxFit.cover,
          );
        },
        itemCount: imagesList.length,
        viewportFraction: 1,
        control: new SwiperControl(color: Colors.grey),
        controller: new SwiperController(),
        pagination: SwiperPagination(),
        scale: 1,
      ),
    );
  }

  // ------------------- PageRoute ------------//
  PageRouteBuilder pageRouteBuilder(int i) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ServiceScreen(i);
      },
      transitionDuration: Duration(milliseconds: 500),
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

  PageRouteBuilder newBikeRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NewBikeScreen();
      },
      transitionDuration: Duration(milliseconds: 200),
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
}
