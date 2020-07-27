import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/pages/shops.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/models/user.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  final Shop shop;
  Location({this.shop});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _districtController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    var adressForm = ListView(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text(
              "Update Location  again",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              _getCurrentLocation();
            },
            color: Colors.amber[700],
          ),
        ),
      ),
      TextFieldWidgetWithValidation('Adress Lane1', _address1Controller),
      TextFieldWidgetWithValidation("Adress Lane2", _address2Controller),
      TextFieldWidgetWithValidation("district,state", _districtController),
      pinCodeWidget("pincode", _pincodeController),
      Container(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: RaisedButton(
              child: Text(
                "Submit".toUpperCase(),
                style: TextStyle(color: Colors.white, letterSpacing: 1),
              ),
              color: Colors.green[700],
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  bool b = await widget.shop.setPosition(
                      latitude: _currentPosition.latitude,
                      longitude: _currentPosition.longitude,
                      adressLane1: _address1Controller.text,
                      pincode: _pincodeController.text,
                      adressLane2: _address2Controller.text);
                  ChangeStatus();
                  if (!b) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("failed to upload")));
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ShopsPage()));
                }
              },
            )),
      )
    ]);
    return Form(
      key: _formKey,
      child: (_currentPosition != null)
          ? adressForm
          : Center(
              child: RaisedButton(
                child: Text(
                  "Get location",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  _getCurrentLocation();
                },
                color: Colors.amber[800],
              ),
            ),
    );
  }

  _getCurrentLocation() async {
    try {
      if (!await geolocator.isLocationServiceEnabled()) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("please enable location service in you device")));
      }
      _currentPosition = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _getAddressFromLatLng();
    } catch (e) {
      if (!await geolocator.isLocationServiceEnabled()) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("please enable location service in you device")));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _address1Controller.text = place.subLocality;
        _address2Controller.text = place.locality;
        _districtController.text =
            place.subAdministrativeArea + ", " + place.administrativeArea;
        _pincodeController.text = place.postalCode;
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class LocationPage extends StatelessWidget {
  final shop;
  LocationPage({this.shop});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Location(
        shop: shop,
      ),
    );
  }
}
