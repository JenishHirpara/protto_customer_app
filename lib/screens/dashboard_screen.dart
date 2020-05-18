import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protto_customer_app/screens/my_bikes_screen.dart';

import './services_screen.dart';
import '../utils/SizeConfig.dart';

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
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    Future showPopup() {
      return showDialog(
        context: context,
        builder: (ctx) => Dialog(
          child: Container(
            height: 210,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Icon(
                          Icons.motorcycle,
                          size: 75,
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: 110,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'My Bike',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromRGBO(100, 100, 100, 1),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('MH 02 KG 0904'),
                            SizedBox(height: 10),
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
                                child: Text('Manage'),
                                elevation: 0,
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(myBikesRouteBuilder());
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  endIndent: 10,
                  indent: 10,
                  thickness: 1,
                  height: 0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: FlatButton(
                      child: Text(
                        '+ Add New Bike',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => showPopup(),
          child: Text(
            'Yamaha FZ',
            style: GoogleFonts.montserrat(
              color: Color.fromRGBO(241, 93, 36, 1),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        leading: Container(),
        elevation: 0,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            onPressed: () {
              // TODO Account icon on pressed...
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey,
            ),
            onPressed: () {
              // TODO Cart icon on pressed...
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          child: SingleChildScrollView(
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 100,
              child: Column(
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 15,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        decoration: new InputDecoration(
                            suffixIcon: Icon(
                              Icons.clear,
                              color: new Color(0xff626262),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: new Color(0xff626262),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            filled: true,
                            hintStyle:
                                new TextStyle(color: new Color(0xff1D1D1)),
                            labelText: "Location",
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 40,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                'Services',
                                style: GoogleFonts.montserrat(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            width: 65,
                                            height: 65,
                                            color: Colors.blueGrey,
                                          ),
                                          Text(
                                            scheduleService,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cantataOne(
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          InkWell(
                                            child: Container(
                                              width: 65,
                                              height: 65,
                                              color: Colors.blueGrey,
                                            ),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(pageRouteBuilder());
                                            },
                                          ),
                                          Text(
                                            regularServices,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cantataOne(
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            width: 65,
                                            height: 65,
                                            color: Colors.blueGrey,
                                          ),
                                          Text(
                                            tyres,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cantataOne(
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            width: 65,
                                            height: 65,
                                            color: Colors.blueGrey,
                                          ),
                                          Text(
                                            washPlusCoat,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cantataOne(
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            width: 65,
                                            height: 65,
                                            color: Colors.blueGrey,
                                          ),
                                          Text(
                                            customRepairs,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cantataOne(
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            width: 65,
                                            height: 65,
                                            color: Colors.blueGrey,
                                          ),
                                          Text(
                                            dentingPainting,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cantataOne(
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
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
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                          child: Text(
                            'Popular Services',
                            style: GoogleFonts.montserrat(
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
            ),
          ),
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
  PageRouteBuilder pageRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ServicesScreen();
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
}
