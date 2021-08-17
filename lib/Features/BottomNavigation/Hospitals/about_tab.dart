import 'dart:async';

import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Features/PublicFunction.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/Hospitals/HospitalsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class About extends StatelessWidget {
  HospitalsModel hospitalsModel;
  About({required this.hospitalsModel});
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker>markers={};

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Marker marker= Marker(
        markerId: MarkerId("1"),
        draggable: true,
        position: LatLng(double.parse(hospitalsModel.lat), double.parse(hospitalsModel.lng)),
        infoWindow: InfoWindow(title: ""),
        icon: BitmapDescriptor.defaultMarker);
    markers.add(marker);
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 60),
            physics: NeverScrollableScrollPhysics(),
            children: [
              Divider(thickness: 8),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 20, bottom: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospitalsModel.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18, height: 2),
                    ),
                  /*  Text(
                      '+5 ' + locale.more!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          height: 2),
                    ),*/
                  ],
                ),
              ),
              Divider(thickness: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Text(
                      locale.address!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Theme.of(context).disabledColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Theme.of(context).disabledColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            hospitalsModel.area.name,
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontSize: 20,
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
              Container(
                height: MediaQuery.of(context).size.height*.4,
                child: GoogleMap(
                  onTap: (LatLong) {},
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    // bearing: 30,
                      target: LatLng(double.parse(hospitalsModel.lat),double.parse(hospitalsModel.lng)),
                      //tilt: 45,
                      zoom: 20),
                  compassEnabled: true,
                  markers: markers,
                ),
              )
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              onTap: () {
               PublicFunction.makingPhoneCall(hospitalsModel.phone);
              },
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 16,
              ),
              label: locale.callNow,
              radius: 0,
            ),
          ),
        ],
      ),
    );
  }
}
