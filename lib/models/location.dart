import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationModel extends ChangeNotifier {
  Position position;
  double radius = 30;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Future<String> getposition() async {
    try {
      if (!await geolocator.isLocationServiceEnabled()) {}
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      notifyListeners();
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
}
