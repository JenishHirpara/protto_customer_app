import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

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
    SizeConfig().init(context);
    return SingleChildScrollView(
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
                          hintStyle: new TextStyle(color: new Color(0xff1D1D1)),
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
}
