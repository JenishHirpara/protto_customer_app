import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  GoogleMapController mapController;
  final _form = GlobalKey<FormState>();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();

  var _address = Address(
    id: DateTime.now().toString(),
    address: '',
    landmark: '',
    saveas: '',
  );

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      _form.currentState.save();
      Provider.of<Addresses>(context, listen: false).addAddress(_address);
      Navigator.of(context).pop();
    }
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Address',
          style: GoogleFonts.montserrat(
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                decoration: new InputDecoration(
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.clear,
                      color: new Color.fromRGBO(150, 150, 150, 1),
                    ),
                    onTap: () {},
                  ),
                  prefixIcon: GestureDetector(
                    child: Icon(
                      Icons.location_on,
                      color: new Color.fromRGBO(150, 150, 150, 1),
                    ),
                    onTap: () {},
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                  filled: true,
                  hintStyle: GoogleFonts.montserrat(
                    color: new Color.fromRGBO(150, 150, 150, 1),
                  ),
                  hintText: "Detect my location",
                  fillColor: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _form,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Text(
                      'FLAT, FLOOR, BUILDING NAME',
                      style: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide flat, floor or building name';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(focusNode2),
                      onSaved: (value) {
                        _address = Address(
                          id: _address.id,
                          address: value,
                          landmark: _address.landmark,
                          saveas: _address.saveas,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'LANDMARK',
                      style: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      focusNode: focusNode2,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(focusNode3),
                      onSaved: (value) {
                        _address = Address(
                          id: _address.id,
                          address: _address.address,
                          landmark: value,
                          saveas: _address.saveas,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'SAVE AS',
                      style: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      focusNode: focusNode3,
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title to this address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _address = Address(
                          id: _address.id,
                          address: _address.address,
                          landmark: _address.landmark,
                          saveas: value,
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepOrange),
                          ),
                          child: RaisedButton(
                            color: Colors.white,
                            elevation: 0,
                            child: Text('BACK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 45,
                          child: RaisedButton(
                            child: Text(
                              'ADD',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.deepOrange,
                            onPressed: _saveForm,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
