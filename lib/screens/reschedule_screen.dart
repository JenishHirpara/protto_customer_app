import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../models/http_exception.dart';

class RescheduleScreen extends StatefulWidget {
  final order;

  RescheduleScreen(this.order);

  @override
  _RescheduleScreenState createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  final _form = GlobalKey<FormState>();

  var _date;
  var _time;

  void _presentDatePicker() {
    var nextYear = DateTime.now().year + 1;
    var month = DateTime.now().month;
    var day = DateTime.now().day;
    var date;
    if (DateTime.now().hour >= 15) {
      date = DateTime.now().add(Duration(days: 1));
    } else {
      date = DateTime.now();
    }
    showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: DateTime(nextYear, month, day),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      var chosenDate = pickedDate.toString().split(' ')[0];
      setState(() {
        _date = chosenDate;
      });
    });
  }

  List<String> _getTime() {
    if (DateTime.now().hour >= 15 || DateTime.now().hour < 9) {
      return ['9-11', '11-1', '1-3', '3-5'];
    } else if (DateTime.now().hour >= 9 && DateTime.now().hour < 11) {
      return ['11-1', '1-3', '3-5'];
    } else if (DateTime.now().hour >= 11 && DateTime.now().hour < 13) {
      return ['1-3', '3-5'];
    } else {
      return ['3-5'];
    }
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    try {
      await Provider.of<Orders>(context, listen: false)
          .editDate(_date, _time, widget.order.bookingId);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on HttpException catch (error) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Too late!',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            content: Text(error.message),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: TextStyle(fontFamily: 'SourceSansProSB'),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reschedule',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: Form(
        key: _form,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select Date and Time',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 45,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
                color: Color.fromRGBO(240, 240, 240, 1),
                child: Align(
                  alignment: Alignment.centerLeft,
                child: Text(
                  _date == null ? 'Date' : _date,
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    color: Color.fromRGBO(128, 128, 128, 1),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
                ),
                elevation: 0,
                onPressed: _presentDatePicker,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Time Slot',
                  hintStyle: TextStyle(
                    fontFamily: 'SourceSansPro',
                    color: Color.fromRGBO(128, 128, 128, 1),
                    fontSize: 14,
                  ),
                ),
                items: _getTime().map<DropdownMenuItem>((value) {
                  return DropdownMenuItem<String>(
                      child: Text(value), value: value);
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please provide time slot';
                  }
                  return null;
                },
                onChanged: (_) {},
                onSaved: (value) {
                  _time = value;
                },
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: double.maxFinite,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
              child: RaisedButton(
                onPressed: _saveForm,
                child: Text(
                  //'Reschedule',
                  'Save',
                  style: TextStyle(
                      fontFamily: 'SourceSansProSB', color: Colors.white),
                ),
                color: Colors.deepOrange,
                elevation: 5,
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
