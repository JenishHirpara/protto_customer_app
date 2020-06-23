import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' as web;

import '../providers/address.dart';

const kGoogleApiKey = "AIzaSyBPPwCzwRTHA89AOoWc9OrZ7ZGLQSVi1lc";

web.GoogleMapsPlaces _places = web.GoogleMapsPlaces(apiKey: kGoogleApiKey);

class EditAddressScreen extends StatefulWidget {
  final Address passedAddress;

  EditAddressScreen(this.passedAddress);
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  GoogleMapController _mapController;
  final _form = GlobalKey<FormState>();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();

  var _address = Address(
    id: DateTime.now().toString(),
    flat: '',
    address: '',
    latitude: '',
    longitude: '',
    landmark: '',
    saveas: '',
  );

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    await Provider.of<Addresses>(context, listen: false)
        .editAddress(widget.passedAddress.id, _address);
    Navigator.of(context).pop();
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
    setState(() {
      _textController.text = _first.addressLine.toString();
    });

    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    // geolocator
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    //     .then((Position position) {
    //   setState(() {
    //     _currentPosition = position;
    //   });
    // }).catchError((e) {
    //   print(e);
    // }).then((_) {
    //   allMarkers.add(
    //     Marker(
    //       markerId: MarkerId('I\'m here'),
    //       draggable: false,
    //       position: new LatLng(
    //         _currentPosition.latitude,
    //         _currentPosition.longitude,
    //       ),
    //     ),
    //   );
    //   _mapController.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         target: new LatLng(
    //           _currentPosition.latitude,
    //           _currentPosition.longitude,
    //         ),
    //         zoom: 12.0,
    //       ),
    //     ),
    //   );
    // });
  }

  var _position;

  _currentLocation(CameraPosition position) {
    setState(() {
      _position = position;
    });
  }

  void _updatePosition() async {
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

    setState(() {
      _textController.text = _first.addressLine.toString();
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
      setState(() {
        _textController.text = _first.addressLine.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: TextField(
        controller: _textController,
        style: TextStyle(color: Colors.deepOrange),
        decoration: InputDecoration(
          hintText: 'Search Address',
          hintStyle: TextStyle(color: Colors.deepOrange),
        ),
        onTap: () async {
          web.Prediction p = await PlacesAutocomplete.show(
            context: context,
            apiKey: kGoogleApiKey,
            language: "en",
            components: [web.Component(web.Component.country, "in")],
            mode: Mode.overlay,
          );
          displayPrediction(p);
        },
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
      titleSpacing: 0.0,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      elevation: 0,
    );
    return Scaffold(
      appBar: _appBar,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
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
              onCameraMove: ((position) => _currentLocation(position)),
              onCameraIdle: _updatePosition,
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height -
                    _appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    40) /
                2,
            right: (MediaQuery.of(context).size.width - 40) / 2,
            child: Tooltip(
              message: 'Move to adjust',
              child: new Icon(
                Icons.person_pin_circle,
                size: 40,
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            maxChildSize: 0.5,
            minChildSize: 0.1,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  color: Colors.white,
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
                          initialValue: widget.passedAddress.flat,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide flat, floor and building name';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(focusNode2),
                          onSaved: (value) {
                            _address = Address(
                              id: _address.id,
                              address: _first.addressLine,
                              flat: value,
                              landmark: _address.landmark,
                              saveas: _address.saveas,
                              latitude: _locationData.latitude.toString(),
                              longitude: _locationData.longitude.toString(),
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
                          initialValue: widget.passedAddress.landmark,
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
                              flat: _address.flat,
                              latitude: _locationData.latitude.toString(),
                              longitude: _locationData.longitude.toString(),
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
                          initialValue: widget.passedAddress.saveas,
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
                              flat: _address.flat,
                              latitude: _locationData.latitude.toString(),
                              longitude: _locationData.longitude.toString(),
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
                                    'SAVE',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.deepOrange,
                                  onPressed: () => _saveForm(),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
