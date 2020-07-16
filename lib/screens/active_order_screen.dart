import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import './jobs_card_screen.dart';
import './inspection_images_screen.dart';
import './reschedule_screen.dart';

class ActiveOrderScreen extends StatefulWidget {
  final OrderItem order;

  ActiveOrderScreen(this.order);

  @override
  _ActiveOrderScreenState createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  final _form = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  var _digit1;
  var _digit2;
  var _digit3;
  var _digit4;
  var _isLoading = false;
  var _order;

  Future showPopUp() {
    FocusScope.of(context).requestFocus(_focusNode1);
    return showDialog(
      context: context,
      builder: (dialogcontext) => Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: double.infinity,
          height: 175,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Text(
                      'OTP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _form,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 45.0,
                        height: 45.0,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 1,
                          focusNode: _focusNode1,
                          onChanged: (_) {
                            FocusScope.of(dialogcontext)
                                .requestFocus(_focusNode2);
                          },
                          onSaved: (value) {
                            _digit1 = value;
                          },
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: 45.0,
                        height: 45.0,
                        alignment: Alignment.center,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 1,
                          focusNode: _focusNode2,
                          onChanged: (_) {
                            FocusScope.of(dialogcontext)
                                .requestFocus(_focusNode3);
                          },
                          onSaved: (value) {
                            _digit2 = value;
                          },
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: 45.0,
                        height: 45.0,
                        alignment: Alignment.center,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 1,
                          focusNode: _focusNode3,
                          onChanged: (_) {
                            FocusScope.of(dialogcontext)
                                .requestFocus(_focusNode4);
                          },
                          onSaved: (value) {
                            _digit3 = value;
                          },
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        width: 45.0,
                        height: 45.0,
                        alignment: Alignment.center,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          maxLength: 1,
                          focusNode: _focusNode4,
                          onSaved: (value) {
                            _digit4 = value;
                          },
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: RaisedButton(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                            color: Colors.white,
                          ),
                        ),
                  color: Theme.of(context).primaryColor,
                  elevation: 5,
                  onPressed: () async {
                    _form.currentState.save();
                    try {
                      setState(() {
                        _isLoading = true;
                      });
                      var message =
                          await Provider.of<Orders>(context, listen: false)
                              .verifyotp(
                                  widget.order.bookingId,
                                  '$_digit1$_digit2$_digit3$_digit4',
                                  widget.order.status);
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(dialogcontext).pop();
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text(message),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Okay'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (error) {
                      print(error.message);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshPage() async {
    _order = await Provider.of<Orders>(context, listen: false)
        .fetchbooking(widget.order.bookingId, widget.order);
    setState(() {});
  }

  List<SampleStepTile> get steps {
    return [
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Service Confirmed',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff707070),
                fontFamily: 'SourceSansPro',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'Reschedule',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    color: Color.fromRGBO(112, 112, 112, 0.7),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      rescheduleRoute(_order == null ? widget.order : _order));
                },
              ),
            ),
          ],
        ),
        date: _order == null ? widget.order.date : _order.date,
        time: _order == null ? widget.order.time : _order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pre Service Inspection',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff707070),
                fontFamily: 'SourceSansPro',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'View Images',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    color: Color.fromRGBO(112, 112, 112, 0.7),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      inspectionRoute(_order == null ? widget.order : _order));
                },
              ),
            ),
          ],
        ),
        date: _order == null ? widget.order.date : _order.date,
        time: _order == null ? widget.order.time : _order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Bike Picked Up',
              style: TextStyle(
                color: Color(0xff707070),
                fontFamily: 'SourceSansPro',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'OTP',
                  style: TextStyle(
                    fontFamily: 'SourcsSansProSB',
                    color: Color.fromRGBO(112, 112, 112, 0.7),
                  ),
                ),
                onPressed: showPopUp,
              ),
            ),
          ],
        ),
        date: _order == null ? widget.order.date : _order.date,
        time: _order == null ? widget.order.time : _order.time,
      ),
      SampleStepTile(
        title: Text(
          'Bike Dropped at Service Station',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            color: Color(0xff707070),
          ),
        ),
        date: widget.order.date,
        time: widget.order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Service Started',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color(0xff707070),
              ),
            ),
            SizedBox(height: 5),
            Text(
              widget.order.ssName == null
                  ? 'Service station not allocated'
                  : widget.order.ssName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 12,
                color: Color.fromRGBO(112, 112, 112, 0.7),
              ),
            ),
          ],
        ),
        date: _order == null ? widget.order.date : _order.date,
        time: _order == null ? widget.order.time : _order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Service Done',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color(0xff707070),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'Invoice',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    color: Color.fromRGBO(112, 112, 112, 0.7),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        date: _order == null ? widget.order.date : _order.date,
        time: _order == null ? widget.order.time : _order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pre Delivery Inspection',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Color(0xff707070),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'View Images',
                  style: TextStyle(
                    fontFamily: 'SourceSansProSB',
                    color: Color.fromRGBO(112, 112, 112, 0.7),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      inspectionRoute(_order == null ? widget.order : _order));
                },
              ),
            ),
          ],
        ),
        date: _order == null ? widget.order.date : _order.date,
        time: _order == null ? widget.order.time : _order.time,
      ),
      SampleStepTile(
        title: Text(
          'Bike Picked from the service station',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            color: Color(0xff707070),
          ),
        ),
        date: widget.order.date,
        time: widget.order.time,
      ),
      SampleStepTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Delivered',
              style: TextStyle(
                color: Color(0xff707070),
                fontFamily: 'SourceSansPro',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: FlatButton(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Text(
                  'OTP',
                  style: TextStyle(
                    fontFamily: 'SourcsSansProSB',
                    color: Color.fromRGBO(112, 112, 112, 0.7),
                  ),
                ),
                onPressed: showPopUp,
              ),
            ),
          ],
        ),
        date: _order == null ? widget.order.date : _order.date,
        time: _order == null ? widget.order.time : _order.time,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Active Order',
          textAlign: TextAlign.left,
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
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.order.make}',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Theme.of(context).primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '${widget.order.model}',
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            widget.order.bikeYear,
                            style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 0.7),
                            ),
                          ),
                          Text(
                            widget.order.bikeNumber,
                            style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.33,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: RaisedButton(
                          child: Text(
                            'Jobs',
                            style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(jobsRoute(
                                _order == null ? widget.order : _order));
                            _refreshPage();
                          },
                          color: Theme.of(context).primaryColor,
                          elevation: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Track the progress',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xff707070),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ...steps.asMap().entries.map((entry) {
                      int index = entry.key;
                      SampleStepTile step = entry.value;
                      return Container(
                        height: 110,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 110,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          DateFormat('dd/MM').format(
                                              DateTime.parse(step.date)),
                                          style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            color: Color.fromRGBO(
                                                128, 128, 128, 1),
                                          ),
                                        ),
                                        Text(
                                          step.time,
                                          style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            color: Color.fromRGBO(
                                                128, 128, 128, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 110,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          int.parse(_order == null
                                                      ? widget.order.status
                                                      : _order.status) >=
                                                  index + 1
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_unchecked,
                                          color: Theme.of(context).primaryColor,
                                          size: 20,
                                        ),
                                        index == 8
                                            ? Container()
                                            : Container(
                                                height: 90,
                                                child: VerticalDivider(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  thickness: 2,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 110,
                                    child: step.title,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SampleStepTile {
  SampleStepTile({
    Key key,
    this.title,
    this.date,
    this.time,
  });

  Widget title;
  String date;
  String time;
}

PageRouteBuilder jobsRoute(OrderItem order) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return JobsCardScreen(order);
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

PageRouteBuilder rescheduleRoute(OrderItem order) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return RescheduleScreen(order);
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

PageRouteBuilder inspectionRoute(OrderItem order) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return InspectionImagesScreen(order);
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
