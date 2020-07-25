import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import './service_screen.dart';
import '../utils/SizeConfig.dart';
import './new_bike_screen.dart';

Color orangeColor = new Color(0xFFF69C7A);
Color greyColor = new Color(0xFFC2C2C2);

List<String> _services = [
  "Regular Service",
  "Tyres",
  "Wash + Coat",
  "Custom Repairs",
  "Denting & Painting",
];

List<String> _images = [
  'assets/images/gear_with_car.png',
  'assets/images/tyres.png',
  'assets/images/wash_plus_coat.png',
  'assets/images/custom_repairs.png',
  'assets/images/denting_penting.png',
];

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
            height: 270,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Thank You for Signing up!!',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
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
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 120,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    elevation: 0,
                    child: Text(
                      'Okay',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSansProSB',
                      ),
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
  void didChangeDependencies() {
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 350,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
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
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: Image(
                                      image: AssetImage(_images[i]),
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    _services[i],
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansSB',
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(pageRouteBuilder(i));
                          },
                        );
                      },
                      itemCount: 5,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 10 / 12,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(26, 0, 0, 5),
                  child: Text(
                    'Popular Services',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: 20,
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
      'assets/images/popular_service_1.png',
      'assets/images/popular_service_2.png',
    ];

    return Container(
      height: 320,
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            imagesList[index],
            fit: BoxFit.cover,
          );
        },
        autoplay: true,
        autoplayDisableOnInteraction: true,
        autoplayDelay: 5000,
        duration: 1000,
        fade: 0.5,
        outer: true,
        itemCount: imagesList.length,
        viewportFraction: 1,
        controller: new SwiperController(),
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Theme.of(context).primaryColor,
            size: 7,
            activeSize: 8,
          ),
        ),
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

  PageRouteBuilder newBikeRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NewBikeScreen();
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
}
