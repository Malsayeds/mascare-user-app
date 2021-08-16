import 'dart:convert';

import 'package:doctoworld_user/Models/Account/AddressModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:http/http.dart'as http;
import 'Config.dart';

class LocationProvider with ChangeNotifier {
  double long = 0.0;
  double lat = 0.0;
  final Set<Marker> listMarkers = {};
  List <AddressModel>addresseslist=[];
  String address = "Current Location";
  late Map<String,dynamic>addAddressInfo;

  Future<void> addAddress(String name,String detailed_address,String area_id,double long,double lat) async{
    String url=Config.base_url+"/patient-addresses";
    print(url);
    var body={
      "name" : name,
      "detailed_address" : detailed_address,
      "area_id":area_id,
      "lng":long.toString(),
      "lat":lat.toString(),
    };
    print(body);
    var header =await Config.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        addAddressInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
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
  Future<void>getAddresses()async {
    var url=Config.base_url+"/patient-addresses";
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        addresseslist= slideritems.map((e) => AddressModel.fromJson(e)).toList();
        print(addresseslist.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}
