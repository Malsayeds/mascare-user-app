import 'package:location/location.dart';

class LocationCore{
  static double lat=0.0;
  static double long=0.0;
  static String locationName="";
  static changeLocation(double long,double lat) {
    LocationCore.long=long;
    LocationCore.lat=lat;
  }
  static getCurrentLocation()async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData.latitude);
    print("locationnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    LocationCore.lat=_locationData.latitude!;
    LocationCore.long=_locationData.longitude!;

  }
}