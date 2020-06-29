import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/bikes.dart';

class NewBikeScreen extends StatefulWidget {
  @override
  _NewBikeScreenState createState() => _NewBikeScreenState();
}

class _NewBikeScreenState extends State<NewBikeScreen> {
  final _form = GlobalKey<FormState>();
  var _selectedModel;

  var _bike = Bike(
    id: DateTime.now().toString(),
    brand: '',
    model: '',
    number: '',
    year: '',
  );

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

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Bikes>(context, listen: false).fetchAllBrands();
    }
    _isInit = false;
    super.didChangeDependencies();
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
    await Provider.of<Bikes>(context, listen: false).addBike(_bike);
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
          'Add New Bike',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w300,
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                children: <Widget>[
                  DropdownButtonFormField(
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
                    items: Provider.of<Bikes>(context)
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
                      _bike = Bike(
                        id: _bike.id,
                        brand: value,
                        model: _bike.model,
                        number: _bike.number,
                        year: _bike.year,
                      );
                    },
                    onChanged: (value) async {
                      await Provider.of<Bikes>(context, listen: false)
                          .fetchAllModels(value);
                      resetModel();
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
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
                      _bike = Bike(
                        id: _bike.id,
                        brand: _bike.brand,
                        model: value,
                        number: _bike.number,
                        year: _bike.year,
                      );
                    },
                    onChanged: (value) {
                      setState(() {
                        _selectedModel = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
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
                      _bike = Bike(
                        id: _bike.id,
                        brand: _bike.brand,
                        model: _bike.model,
                        number: _bike.number,
                        year: value,
                      );
                    },
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 10),
                  TextFormField(
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
                      _bike = Bike(
                        id: _bike.id,
                        brand: _bike.brand,
                        model: _bike.model,
                        number: value,
                        year: _bike.year,
                      );
                    },
                  ),
                  SizedBox(height: 28),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontFamily: 'SourceSansProSB', fontSize: 15),
                      ),
                      onPressed: _saveForm,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
