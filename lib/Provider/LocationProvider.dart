import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocode;

class LocationProvider with ChangeNotifier {
  double long = 0.0;
  double lat = 0.0;
  final Set<Marker> listMarkers = {};
  String address = "Current Location";

  makeMarker() async {
    listMarkers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onDragEnd: (LatLng) async {
          this.changeLocation(LatLng.longitude, LatLng.latitude);
        },
        position: LatLng(this.lat, this.long),
        infoWindow: InfoWindow(title: "Current Location"),
        icon: BitmapDescriptor.defaultMarker));
    //  newPlace = await placemarkFromCoordinates(longitude,longitude);
  }

  changeLocation(double long, double lat) async {
    this.long = long;
    this.lat = lat;
    List<geocode.Placemark> placemarks =
        await geocode.placemarkFromCoordinates(this.lat, this.long);
    this.address = placemarks[0].country! + " " + placemarks[0].street!;
    this.makeMarker();
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

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
    this.lat = _locationData.latitude!;
    this.long = _locationData.longitude!;
    List<geocode.Placemark> placemarks =
        await geocode.placemarkFromCoordinates(this.lat, this.long);
    this.address = placemarks[0].country! + " " + placemarks[0].street!;
    this.makeMarker();
    notifyListeners();
  }
}
