import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/bikes.dart';

class EditBikeScreen extends StatefulWidget {
  final Bike bike;

  EditBikeScreen(this.bike);

  @override
  _EditBikeScreenState createState() => _EditBikeScreenState();
}

class _EditBikeScreenState extends State<EditBikeScreen> {
  final _form = GlobalKey<FormState>();
  var dupbike;
  var _brand;
  var _model;
  var _rgno;
  var _year;
  var _id;
  var _selectedModel;

  List<String> getYears() {
    var currentDate = DateTime.now();
    var formatter = new DateFormat('yyyy');
    var currentYear = formatter.format(currentDate);
    var previousYear = '${int.parse(currentYear) - 101}';
    return List<String>.generate(100, (index) {
      previousYear = '${int.parse(previousYear) + 1}';
      return '${int.parse(previousYear) + 1}';
    }).reversed.toList();
  }

  void resetModel() {
    setState(() {
      _selectedModel = null;
    });
  }

  var _isInit = true;
  var _isLoading = false;
  var _isLoading1 = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Bikes>(context, listen: false).fetchAllBrands();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _brand = widget.bike.brand;
    _model = widget.bike.model;
    _rgno = widget.bike.number;
    _year = widget.bike.year;
    _id = widget.bike.id;
    super.initState();
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Bikes>(context, listen: false).updateBike(
        brand: _brand, id: _id, model: _model, number: _rgno, year: _year);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.bike.brand} ${widget.bike.model}',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Theme.of(context).primaryColor,
            fontSize: 22,
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
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                children: <Widget>[
                  DropdownButtonFormField(
                    value: _brand,
                    decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Brand',
                      hintStyle: TextStyle(
                        fontFamily: 'SourceSansPro',
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontSize: 14,
                      ),
                    ),
                    items: Provider.of<Bikes>(context, listen: false)
                        .brands
                        .map<DropdownMenuItem>((value) {
                      return DropdownMenuItem<String>(
                          child: Text(value,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                              )),
                          value: value);
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please provide brand name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _brand = value;
                    },
                    onChanged: (value) async {
                      setState(() {
                        _isLoading1 = true;
                      });
                      await Provider.of<Bikes>(context, listen: false)
                          .fetchAllModels(value);
                      setState(() {
                        _isLoading1 = false;
                      });
                      resetModel();
                    },
                  ),
                  SizedBox(height: 10),
                  _isLoading1
                      ? Center(
                          child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ))
                      : DropdownButtonFormField(
                          value: _selectedModel,
                          decoration: InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Model',
                            hintStyle: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontSize: 14,
                            ),
                          ),
                          items: Provider.of<Bikes>(context)
                              .models
                              .map<DropdownMenuItem>((value) {
                            return DropdownMenuItem<String>(
                                child: Text(value,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                    )),
                                value: value);
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please provide model name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _model = value;
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedModel = value;
                            });
                          },
                        ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    value: _year,
                    decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Year',
                      hintStyle: TextStyle(
                        fontFamily: 'SourceSansPro',
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontSize: 14,
                      ),
                    ),
                    items: getYears().map<DropdownMenuItem>((value) {
                      return DropdownMenuItem<String>(
                          child: Text(value,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                              )),
                          value: value);
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please provide year of purchase';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _year = value;
                    },
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _rgno,
                    decoration: InputDecoration(
                      hintText: 'Registration Number',
                      hintStyle: TextStyle(
                        fontFamily: 'SourceSansPro',
                        color: Color.fromRGBO(128, 128, 128, 1),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide registration number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _rgno = value;
                    },
                  ),
                  SizedBox(height: 28),
                  Container(
                    height: 40,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Edit',
                          style: TextStyle(
                            fontFamily: 'SourceSansProSB',
                          )),
                      onPressed: _saveForm,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
