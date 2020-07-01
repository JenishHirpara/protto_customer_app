import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import './service_screen.dart';
import '../utils/SizeConfig.dart';
import './my_bikes_screen.dart';
import './new_bike_screen.dart';
import './shopping_cart_screen.dart';
import './user_profile_screen.dart';
import '../providers/bikes.dart';
import '../providers/address.dart';
import '../providers/cart_item.dart';
import '../utils/badge.dart';

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
  Future showPopup(BuildContext originalcontext, Bike activebike) {
    return showDialog(
      context: originalcontext,
      builder: (context) => Dialog(
        child: Container(
          height: 220,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                  child: InkWell(
                    child: Icon(
                      Icons.clear,
                      size: 24,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Container(
                height: 140,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          activebike != null
                              ? '${activebike.brand} ${activebike.model}'
                              : 'My Bike',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(241, 93, 36, 1),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Year: '),
                        Text(
                          activebike != null ? activebike.year : 'My Bike',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color.fromRGBO(100, 100, 100, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Registration Number: '),
                        Text(
                          activebike != null ? activebike.number : '',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            color: Color.fromRGBO(100, 100, 100, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(
                          'Manage',
                          style: TextStyle(fontFamily: 'SourceSansProSB'),
                        ),
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(originalcontext)
                              .push(myBikesRouteBuilder());
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                endIndent: 10,
                indent: 10,
                thickness: 1,
                height: 0,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: FlatButton(
                    child: Text(
                      '+ Add New Bike',
                      style: TextStyle(
                        fontFamily: 'SourceSansProSB',
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(originalcontext).push(myBikesRouteBuilder());
                      Navigator.of(originalcontext).push(newBikeRouteBuilder());
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                        fontFamily: 'SourceSansPro',
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
      Provider.of<Bikes>(context).fetchAndSetBikes();
      Provider.of<Addresses>(context).fetchAndSetAddresses();
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
    final activebike = Provider.of<Bikes>(context).activeBike;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => showPopup(context, activebike),
          child: Text(
            activebike != null
                ? '${activebike.brand} ${activebike.model}'
                : '+ Add a Bike',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Color.fromRGBO(241, 93, 36, 1),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        titleSpacing: 20,
        elevation: 0,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).push(profileScreenPageRoute());
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(shoppingCartRouteBuilder());
              },
            ),
          ),
        ],
      ),
      body: Container(
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
                            fontSize: 18,
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
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
                                          height:
                                              SizeConfig.blockSizeVertical * 10,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/images/gear_with_car.png'))),
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
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
                                          height:
                                              SizeConfig.blockSizeVertical * 10,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/images/tyres.png'))),
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
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
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
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
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
                                              SizeConfig.blockSizeHorizontal *
                                                  25,
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
                        fontSize: 18,
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

  PageRouteBuilder myBikesRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return MyBikesScreen();
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

  PageRouteBuilder shoppingCartRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ShoppingCartScreen();
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

  PageRouteBuilder profileScreenPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return UserProfileScreen();
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
}
