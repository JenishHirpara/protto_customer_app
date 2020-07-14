import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/orders.dart';
import './shopping_cart_screen.dart';
import '../utils/job_item.dart';
import '../utils/additional_job_item.dart';

class JobsCardScreen extends StatefulWidget {
  final OrderItem order;

  JobsCardScreen(this.order);

  @override
  _JobsCardScreenState createState() => _JobsCardScreenState();
}

class _JobsCardScreenState extends State<JobsCardScreen> {
  String alertDialogText = "You have approved all of your \n" +
      "additional services. Your new total is ";

  String alertDialogTwo = "You did not approve all the services \n" +
      "suggested in the job card. Are you sure \n" +
      "you still want to move forward without \n" +
      "those services? ";

  void _launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<dynamic> approveAllAlertDialog(
      BuildContext context, List<String> data) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return Dialog(
            elevation: 5,
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: RichText(
                      text: TextSpan(
                        text: alertDialogText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "₹ $_total",
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(dialogcontext).pop();
                          },
                          elevation: 5,
                          child: Text(
                            'Jobs',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        RaisedButton(
                          elevation: 5,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(dialogcontext).pop();

                            setState(() {
                              _isLoading = true;
                            });
                            await Provider.of<Orders>(context, listen: false)
                                .jobapprove(widget.order.bookingId, data,
                                    _total, _paid);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> approveSelectedAlertDialog(
      BuildContext context, List<String> data) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return Dialog(
            elevation: 5,
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: 400,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: RichText(
                      text: TextSpan(
                        text: alertDialogTwo,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(dialogcontext).pop();

                            setState(() {
                              _isLoading = true;
                            });
                            await Provider.of<Orders>(context, listen: false)
                                .jobapprove(widget.order.bookingId, data,
                                    _total, _paid);
                            Navigator.of(context).pop();
                          },
                          elevation: 5,
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(dialogcontext).pop();
                          },
                          elevation: 5,
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontFamily: 'SourceSansProSB',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
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

  var _isInit = true;
  var _isLoading = true;
  List<Jobs> allJobs;
  List<bool> _approval;
  List<Jobs> approvedJobs;
  List<String> approvedJobId = [];
  var _total = '0.0';
  var _paid = '0.0';
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _total = widget.order.total;
      _paid = widget.order.paid;
      await Provider.of<Orders>(context, listen: false)
          .getservices(widget.order.bookingId);
      await Provider.of<Orders>(context, listen: false)
          .getjobs(widget.order.bookingId);
      setState(() {
        _isLoading = false;
      });
      allJobs = Provider.of<Orders>(context, listen: false).jobs;
      _approval = List.generate(allJobs.length, (job) => false);
      approvedJobs = Provider.of<Orders>(context, listen: false)
          .jobs
          .where((job) => job.approved == '1')
          .toList();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.order.make} ${widget.order.model}',
          style: GoogleFonts.montserrat(
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
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pre - Booked Services',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) => JobItem(
                          Provider.of<Orders>(context, listen: false)
                              .services[i]),
                      itemCount: Provider.of<Orders>(context, listen: false)
                          .services
                          .length,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Additional Services',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    widget.order.approveJobs == '0'
                        ? allJobs == null
                            ? Text(
                                'Please wait for the service station to recommend additional jobs')
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, i) => ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  title: Text(
                                    allJobs[i].name,
                                    style: GoogleFonts.cantataOne(
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 100,
                                    height: 20,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '₹ ${allJobs[i].cost}',
                                          style: GoogleFonts.cantataOne(
                                            color: Color.fromRGBO(
                                                128, 128, 128, 1),
                                          ),
                                        ),
                                        Checkbox(
                                            value: _approval[i],
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                if (!_approval[i]) {
                                                  approvedJobId
                                                      .add(allJobs[i].id);
                                                  _total =
                                                      '${double.parse(_total) + double.parse(allJobs[i].cost)}';
                                                } else {
                                                  approvedJobId
                                                      .remove(allJobs[i].id);
                                                  _total =
                                                      '${double.parse(_total) - double.parse(allJobs[i].cost)}';
                                                }
                                                _approval[i] = !_approval[i];
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                                itemCount: allJobs.length,
                              )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, i) =>
                                AdditionalJobItem(approvedJobs[i]),
                            itemCount: approvedJobs.length,
                          ),
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 18, 0),
                      title: Text(
                        'Item Total',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Text(
                          '₹ $_total',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 18, 0),
                      title: Text(
                        'Paid',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Text(
                          '₹ $_paid',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 18, 0),
                      title: Text(
                        'Due',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 20,
                        child: Text(
                          '₹ ${double.parse(_total) - double.parse(_paid)}',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    widget.order.approveJobs == '0' && allJobs != null
                        ? Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 0),
                              color: Theme.of(context).primaryColor,
                              height: 50,
                              width: double.infinity,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                onPressed: () {
                                  for (int i = 0; i < _approval.length; i++) {
                                    if (!_approval[i]) {
                                      setState(() {
                                        _approval[i] = true;
                                        approvedJobId.add(allJobs[i].id);
                                        _total =
                                            '${double.parse(_total) + double.parse(allJobs[i].cost)}';
                                      });
                                    }
                                  }
                                  approveAllAlertDialog(context, approvedJobId);
                                },
                                child: Text(
                                  'Approve All',
                                  style: TextStyle(
                                    fontFamily: 'SourceSansProSB',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    widget.order.approveJobs == '0' && allJobs != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(3.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0, 2.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    elevation: 0,
                                    child: Text(
                                      'Approve Selected',
                                      style: TextStyle(
                                        fontFamily: 'SourceSansProSB',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onPressed: () {
                                      approveSelectedAlertDialog(
                                          context, approvedJobId);
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(3.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0, 2.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    elevation: 0,
                                    child: Text(
                                      'Contact Support',
                                      style: TextStyle(
                                          fontFamily: 'SourceSansProSB',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                    onPressed: () =>
                                        _launchCaller('tel:+919136863480'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
    );
  }
}
