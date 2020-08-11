import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

import '../providers/orders.dart';

class InspectionImagesScreen extends StatefulWidget {
  final OrderItem order;

  InspectionImagesScreen(this.order);

  @override
  _InspectionImagesScreenState createState() => _InspectionImagesScreenState();
}

class _InspectionImagesScreenState extends State<InspectionImagesScreen> {
  var _isLoading = true;
  var _isInit = true;
  List<String> preImgUrl = [];
  List<String> postImgUrl = [];
  var getPreOdometer;
  var getPostOdometer;
  var getPreFuel;
  var getPostFuel;

  List<String> _names = [
    'Front',
    'Left',
    'Rear',
    'Right',
    'Dash-\nBoard',
    'No.Plate'
  ];

  void _showDialog(int index, String number) {
    showDialog(
      context: context,
      builder: (ctx) {
        return PhotoView.customChild(
          onTapUp: (_, __, ___) {
            Navigator.of(ctx).pop();
          },
          child: number == '1'
              ? Image.memory(
                  Base64Decoder().convert(preImgUrl[index]),
                  fit: BoxFit.cover,
                )
              : Image.memory(
                  Base64Decoder().convert(postImgUrl[index]),
                  fit: BoxFit.cover,
                ),
          childSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.5),
          backgroundDecoration: BoxDecoration(),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
          tightMode: true,
        );
      },
    );
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Orders>(context, listen: false)
          .getpreimages(widget.order.bookingId);
      await Provider.of<Orders>(context, listen: false)
          .getpostimages(widget.order.bookingId);
      setState(() {
        _isLoading = false;
      });
      preImgUrl = Provider.of<Orders>(context, listen: false).preImages;
      postImgUrl = Provider.of<Orders>(context, listen: false).postImages;
      getPreOdometer =
          Provider.of<Orders>(context, listen: false).preOdometerReading;
      getPostOdometer =
          Provider.of<Orders>(context, listen: false).postOdometerReading;
      getPreFuel = Provider.of<Orders>(context, listen: false).preFuelLevel;
      getPostFuel = Provider.of<Orders>(context, listen: false).postFuelLevel;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspection Images',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(112, 112, 112, 1),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: Image.asset(
                'assets/images/loader.gif',
                fit: BoxFit.cover,
                height: 85,
                width: 85,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.order.make} ${widget.order.model}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.order.bikeYear,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(128, 128, 128, 1),
                          ),
                        ),
                        Text(
                          widget.order.bikeNumber,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(128, 128, 128, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36),
                    child: Text(
                      'Pre Service Inspection',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  preImgUrl.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 38, vertical: 0),
                          child: GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            children: List.generate(
                              preImgUrl.length,
                              (index) {
                                return Container(
                                  child: InkWell(
                                    child: GridTile(
                                      footer: GridTileBar(
                                        backgroundColor:
                                            Color.fromRGBO(220, 220, 220, 0.4),
                                        title: Text(
                                          _names[index],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Image.memory(
                                        Base64Decoder()
                                            .convert(preImgUrl[index]),
                                        fit: BoxFit.cover,
                                        height: 300,
                                        width: 300,
                                      ),
                                    ),
                                    onTap: () => _showDialog(index, '1'),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Color.fromRGBO(240, 240, 240, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Odometer:',
                          style: GoogleFonts.cantataOne(
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        SizedBox(width: 15),
                        getPreOdometer == null
                            ? Text(
                                'not set',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                getPreOdometer,
                                style: GoogleFonts.cantataOne(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Color.fromRGBO(240, 240, 240, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Fuel Level:',
                          style: GoogleFonts.cantataOne(
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        SizedBox(width: 15),
                        getPreFuel == null
                            ? Text(
                                'not set',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                getPreFuel,
                                style: GoogleFonts.cantataOne(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36),
                    child: Text(
                      'Pre Delivery Inspection',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  postImgUrl.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 38, vertical: 0),
                          child: GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            children: List.generate(
                              postImgUrl.length,
                              (index) {
                                return Container(
                                  child: InkWell(
                                    child: GridTile(
                                      footer: GridTileBar(
                                        backgroundColor:
                                            Color.fromRGBO(220, 220, 220, 0.4),
                                        title: Text(
                                          _names[index],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Image.memory(
                                        Base64Decoder()
                                            .convert(postImgUrl[index]),
                                        fit: BoxFit.cover,
                                        height: 300,
                                        width: 300,
                                      ),
                                    ),
                                    onTap: () => _showDialog(index, '2'),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Color.fromRGBO(240, 240, 240, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Odometer:',
                          style: GoogleFonts.cantataOne(
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        SizedBox(width: 15),
                        getPostOdometer == null
                            ? Text(
                                'not set',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                getPostOdometer,
                                style: GoogleFonts.cantataOne(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Color.fromRGBO(240, 240, 240, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Fuel Level:',
                          style: GoogleFonts.cantataOne(
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        SizedBox(width: 15),
                        getPostFuel == null
                            ? Text(
                                'not set',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                getPostOdometer,
                                style: GoogleFonts.cantataOne(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
