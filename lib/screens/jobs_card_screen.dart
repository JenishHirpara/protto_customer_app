import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/orders.dart';
import '../utils/job_item.dart';
import '../utils/additional_job_item.dart';
import './no_internet_screen.dart';

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
                            'Back to Jobs',
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
                            'Done',
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
                            try {
                              await Provider.of<Orders>(context, listen: false)
                                  .jobapprove(widget.order.bookingId, data,
                                      _total, _paid);
                              setState(() {
                                _isLoading = false;
                                _isInternet = true;
                              });
                              Navigator.of(context).pop();
                            } catch (error) {
                              print(error.message);
                              if (error.message
                                  .toString()
                                  .contains('Failed host lookup')) {
                                setState(() {
                                  _isLoading = false;
                                  _isInternet = false;
                                });
                              }
                            }
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
                            try {
                              await Provider.of<Orders>(context, listen: false)
                                  .jobapprove(widget.order.bookingId, data,
                                      _total, _paid);
                              setState(() {
                                _isLoading = false;
                                _isInternet = true;
                              });
                              Navigator.of(context).pop();
                            } catch (error) {
                              print(error.message);
                              if (error.message
                                  .toString()
                                  .contains('Failed host lookup')) {
                                setState(() {
                                  _isLoading = false;
                                  _isInternet = false;
                                });
                              }
                            }
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

  void retry() async {
    try {
      setState(() {
        _isLoading = true;
        _isInternet = true;
      });
      await Provider.of<Orders>(context, listen: false)
          .getservices(widget.order.bookingId);
      await Provider.of<Orders>(context, listen: false)
          .getjobs(widget.order.bookingId);
      setState(() {
        _isLoading = false;
      });
      allJobs = Provider.of<Orders>(context, listen: false).jobs;
      newJobs = Provider.of<Orders>(context, listen: false)
          .jobs
          .where((job) => job.approved == '0')
          .toList();
      _approval = List.generate(newJobs.length, (job) => false);
      approvedJobs = Provider.of<Orders>(context, listen: false)
          .jobs
          .where((job) => job.approved == '1')
          .toList();
    } catch (error) {
      print(error.message);
      if (error.message.toString().contains('Failed host lookup')) {
        setState(() {
          _isLoading = false;
          _isInternet = false;
        });
      }
    }
  }

  var _isInit = true;
  var _isLoading = false;
  var _isInternet = true;
  List<Jobs> allJobs;
  List<bool> _approval;
  List<Jobs> approvedJobs;
  List<Jobs> newJobs;
  List<String> approvedJobId = [];
  var _total = '0.0';
  var _paid = '0.0';

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _total = widget.order.total;
      _paid = widget.order.paid;
      try {
        setState(() {
          _isLoading = true;
          _isInternet = true;
        });
        await Provider.of<Orders>(context, listen: false)
            .getservices(widget.order.bookingId);
        await Provider.of<Orders>(context, listen: false)
            .getjobs(widget.order.bookingId);
        setState(() {
          _isLoading = false;
        });
        allJobs = Provider.of<Orders>(context, listen: false).jobs;
        newJobs = Provider.of<Orders>(context, listen: false)
            .jobs
            .where((job) => job.approved == '0')
            .toList();
        _approval = List.generate(newJobs.length, (job) => false);
        approvedJobs = Provider.of<Orders>(context, listen: false)
            .jobs
            .where((job) => job.approved == '1')
            .toList();
      } catch (error) {
        print(error.message);
        if (error.message.toString().contains('Failed host lookup')) {
          setState(() {
            _isLoading = false;
            _isInternet = false;
          });
        }
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.order.make}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Theme.of(context).primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${widget.order.model}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
          : _isInternet
              ? SingleChildScrollView(
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
                        SizedBox(height: 14),
                        widget.order.approveJobs == '0'
                            ? newJobs.isEmpty
                                ? Text(
                                    'Please wait for the service station to recommend additional jobs',
                                    style: TextStyle(
                                      fontFamily: 'SourceSansProSB',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, i) => ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      title: Text(
                                        newJobs[i].name,
                                        style: TextStyle(
                                          fontFamily: 'SourceSansPro',
                                          color:
                                              Color.fromRGBO(128, 128, 128, 1),
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 100,
                                        height: 20,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              '₹ ${newJobs[i].cost}',
                                              style: TextStyle(
                                                fontFamily: 'SourceSansPro',
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
                                                          .add(newJobs[i].id);
                                                      _total =
                                                          '${double.parse(_total) + double.parse(allJobs[i].cost)}';
                                                    } else {
                                                      approvedJobId.remove(
                                                          newJobs[i].id);
                                                      _total =
                                                          '${double.parse(_total) - double.parse(allJobs[i].cost)}';
                                                    }
                                                    _approval[i] =
                                                        !_approval[i];
                                                  });
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    itemCount: newJobs.length,
                                  )
                            : approvedJobs.isEmpty
                                ? Text(
                                    'You did not select any additional service',
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, i) =>
                                        AdditionalJobItem(approvedJobs[i]),
                                    itemCount: approvedJobs.length,
                                  ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Item Total',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontWeight: FontWeight.bold,
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
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Paid',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontWeight: FontWeight.bold,
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
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Due',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontWeight: FontWeight.bold,
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
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        widget.order.approveJobs == '0' && newJobs.isNotEmpty
                            ? Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  height: 50,
                                  width: double.infinity,
                                  child: RaisedButton(
                                    elevation: 3,
                                    color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    onPressed: () {
                                      for (int i = 0;
                                          i < _approval.length;
                                          i++) {
                                        if (!_approval[i]) {
                                          setState(() {
                                            _approval[i] = true;
                                            approvedJobId.add(newJobs[i].id);
                                            _total =
                                                '${double.parse(_total) + double.parse(newJobs[i].cost)}';
                                          });
                                        }
                                      }
                                      approveAllAlertDialog(
                                          context, approvedJobId);
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
                        widget.order.approveJobs == '0' && newJobs.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: RaisedButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                        borderRadius:
                                            BorderRadius.circular(3.0),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: RaisedButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
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
                )
              : NoInternetScreen(retry),
    );
  }
}
