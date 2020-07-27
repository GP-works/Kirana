import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationModel extends ChangeNotifier {
  Position position;
  double radius;
  LocationModel() {
    this.radius = 5;
  }
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Future<String> getposition() async {
    try {
      if (!await geolocator.isLocationServiceEnabled()) {}
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      notifyListeners();
      WritetoSp();
      return "succes";
    } catch (e) {
      if (!await geolocator.isLocationServiceEnabled()) {
        return "please enable location service";
      } else {
        return e.message;
      }
    }
  }

  void setradius(double radius) {
    this.radius = radius;
    notifyListeners();
  }

  void readFromSf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double latitude = prefs.getDouble('latitude');
    double longitude = prefs.getDouble('longitude');
    radius = prefs.getDouble('radius');
    print("$latitude$longitude$radius");
    if (latitude != null && longitude != null) {
      position = Position(latitude: latitude, longitude: longitude);
      notifyListeners();
    }
  }

  void WritetoSp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("${position.latitude}$radius");
    prefs.setDouble('latitude', position.latitude);
    prefs.setDouble('longitude', position.longitude);
    prefs.setDouble('radius', this.radius);
  }
}
