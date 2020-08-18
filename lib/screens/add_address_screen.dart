import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' as web;

import '../providers/address.dart';

const kGoogleApiKey = "AIzaSyAphGxn5W8zr_gOduftWlO8oHCSDIhkRlk";

web.GoogleMapsPlaces _places = web.GoogleMapsPlaces(apiKey: kGoogleApiKey);

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  GoogleMapController _mapController;
  final _form = GlobalKey<FormState>();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  var _showFull = true;
  var _isInit = true;
  var _isLoading = true;
  var _isLoading1 = true;
  List<String> _pin;
  String pin;

  var _address = Address(
    id: DateTime.now().toString(),
    flat: '',
    address: '',
    latitude: '',
    longitude: '',
    landmark: '',
    saveas: '',
    active: '0',
  );

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    var id = await Provider.of<Addresses>(context, listen: false)
        .addAddress(_address);
    _address = Address(
      address: _address.address,
      flat: _address.flat,
      id: id,
      landmark: _address.landmark,
      latitude: _address.latitude,
      longitude: _address.longitude,
      saveas: _address.saveas,
      active: _address.active,
    );
    Navigator.of(context).pop(_address);
  }

  Location _location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  var _locationData;
  var _addresses;
  var _coordinates;
  var _first;
  var _textController = TextEditingController();

  _getCurrentLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }
    if (!_serviceEnabled) {
      return;
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
    _locationData = await _location.getLocation();

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: new LatLng(
            _locationData.latitude,
            _locationData.longitude,
          ),
          zoom: 16.0,
        ),
      ),
    );

    _coordinates =
        geo.Coordinates(_locationData.latitude, _locationData.longitude);
    _addresses =
        await geo.Geocoder.local.findAddressesFromCoordinates(_coordinates);
    _first = _addresses[0];
    pin = _first.postalCode;
    setState(() {
      _textController.text = _first.addressLine.toString();
      _isLoading1 = false;
    });
  }

  var _position;

  _currentLocation(CameraPosition position) {
    setState(() {
      _position = position;
    });
  }

  void _updatePosition() async {
    setState(() {
      _isLoading1 = true;
    });
    var latitude = _position.target.latitude == null
        ? _locationData.latitude
        : _position.target.latitude;
    var longitude = _position.target.longitude == null
        ? _locationData.longitude
        : _position.target.longitude;
    _coordinates = geo.Coordinates(latitude, longitude);
    _addresses =
        await geo.Geocoder.local.findAddressesFromCoordinates(_coordinates);
    _first = _addresses[0];
    pin = _first.postalCode;
    setState(() {
      _textController.text = _first.addressLine.toString();
      _isLoading1 = false;
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Future<void> displayPrediction(web.Prediction p) async {
    if (p != null) {
      web.PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: new LatLng(
              lat,
              lng,
            ),
            zoom: 16.0,
          ),
        ),
      );

      _coordinates = geo.Coordinates(lat, lng);
      _addresses =
          await geo.Geocoder.local.findAddressesFromCoordinates(_coordinates);
      _first = _addresses[0];
      pin = _first.postalCode;
      setState(() {
        _textController.text = _first.addressLine.toString();
      });
    }
  }

  void _setFull() {
    setState(() {
      _showFull = !_showFull;
    });
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Addresses>(context, listen: false).getpin();
      _pin = Provider.of<Addresses>(context, listen: false).pincodes;
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Add Address',
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () async {
            web.Prediction p = await PlacesAutocomplete.show(
              context: context,
              apiKey: kGoogleApiKey,
              language: "en",
              components: [web.Component(web.Component.country, "in")],
              types: ["establishment"],
              mode: Mode.overlay,
            );
            displayPrediction(p);
          },
        ),
      ],
      leading: InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(112, 112, 112, 1),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      titleSpacing: 0.0,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      elevation: 0,
    );
    return Scaffold(
      appBar: _appBar,
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
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: (MediaQuery.of(context).size.height -
                                _appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            (_showFull ? 0.65 : 0.5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            _mapController = controller;
                          },
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(19.0760, 72.8777),
                            zoom: 12.0,
                            bearing: 15,
                            tilt: 75,
                          ),
                          onCameraMoveStarted: _showFull ? () {} : _setFull,
                          onTap: _showFull ? (_) {} : (_) => _setFull(),
                          onCameraMove: ((position) =>
                              _currentLocation(position)),
                          onCameraIdle: _updatePosition,
                        ),
                      ),
                      Positioned(
                        top: (MediaQuery.of(context).size.height -
                                _appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top -
                                80) *
                            (_showFull ? 0.65 : 0.5) /
                            2,
                        right: (MediaQuery.of(context).size.width - 40) / 2,
                        child: Image.asset(
                          'assets/images/location.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                  _showFull
                      ? Container(
                          height: (MediaQuery.of(context).size.height -
                                  _appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.35,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        _isLoading1
                                            ? Expanded(
                                                flex: 8,
                                                child: Row(
                                                  children: <Widget>[
                                                    CircularProgressIndicator(),
                                                    Container(),
                                                  ],
                                                ),
                                              )
                                            : Expanded(
                                                flex: 8,
                                                child: Text(
                                                  _first.thoroughfare != null
                                                      ? _first.thoroughfare
                                                      : _first.featureName,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  softWrap: true,
                                                ),
                                              ),
                                        Expanded(
                                          flex: 3,
                                          child: FlatButton(
                                            onPressed: () async {
                                              web.Prediction p =
                                                  await PlacesAutocomplete.show(
                                                context: context,
                                                apiKey: kGoogleApiKey,
                                                language: "en",
                                                components: [
                                                  web.Component(
                                                    web.Component.country,
                                                    "in",
                                                  )
                                                ],
                                                mode: Mode.overlay,
                                              );
                                              displayPrediction(p);
                                            },
                                            child: Text(
                                              'CHANGE',
                                              style: TextStyle(
                                                fontFamily: 'SourceSansProSB',
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _textController.text,
                                        style: TextStyle(
                                          fontFamily: 'SourceSansPro',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 14),
                              Container(
                                height: 40,
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  onPressed:
                                      _pin.contains(pin) ? _setFull : () {},
                                  child: Text(
                                    _pin.contains(pin)
                                        ? 'Next'
                                        : 'Out Of Coverage',
                                    style: TextStyle(
                                        fontFamily: 'SourceSansProSB',
                                        color: Colors.white),
                                  ),
                                  color: _pin.contains(pin)
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey,
                                  elevation: _pin.contains(pin) ? 5 : 0,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          height: (MediaQuery.of(context).size.height -
                                  _appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.5,
                          child: Form(
                            key: _form,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Text(
                                  'FLAT, FLOOR, BUILDING NAME',
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                  ),
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please provide flat, floor and building name';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(focusNode2),
                                  onSaved: (value) {
                                    _address = Address(
                                      id: _address.id,
                                      address: _first.addressLine,
                                      flat: value,
                                      landmark: _address.landmark,
                                      saveas: _address.saveas,
                                      active: _address.active,
                                      latitude:
                                          _locationData.latitude.toString(),
                                      longitude:
                                          _locationData.longitude.toString(),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'LANDMARK',
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                  ),
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  focusNode: focusNode2,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(focusNode3),
                                  onSaved: (value) {
                                    _address = Address(
                                      id: _address.id,
                                      address: _address.address,
                                      landmark: value,
                                      saveas: _address.saveas,
                                      active: _address.active,
                                      flat: _address.flat,
                                      latitude:
                                          _locationData.latitude.toString(),
                                      longitude:
                                          _locationData.longitude.toString(),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'SAVE AS',
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
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
                                      active: _address.active,
                                      flat: _address.flat,
                                      latitude:
                                          _locationData.latitude.toString(),
                                      longitude:
                                          _locationData.longitude.toString(),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                      ),
                                      child: RaisedButton(
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Text(
                                          'BACK',
                                          style: TextStyle(
                                              fontFamily: 'SourceSansProSB'),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 45,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                          ),
                                          child: Text(
                                            'ADD',
                                            style: TextStyle(
                                                fontFamily: 'SourceSansProSB',
                                                color: Colors.white),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          elevation: 5,
                                          onPressed: () => _saveForm(),
                                        )),
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
