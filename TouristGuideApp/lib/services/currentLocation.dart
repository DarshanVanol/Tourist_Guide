import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  Future<double> getlatitude() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position.latitude;
  }

  getlongitude() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position.longitude;
  }
}
