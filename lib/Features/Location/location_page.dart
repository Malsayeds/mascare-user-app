import 'dart:async';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/LocationProvider.dart';
import 'package:doctoworld_user/Provider/locationCore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'address_type_button.dart';

TextEditingController _addressController = TextEditingController();

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocationProvider(), child: SetLocation());
  }
}

class SetLocation extends StatefulWidget {
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  bool isCard = false;
  Completer<GoogleMapController> _controller = Completer();
  late List<Placemark> newPlace;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    await locationProvider.getCurrentLocation();

    final CameraPosition position = CameraPosition(
      target: LatLng(locationProvider.lat, locationProvider.long),
      zoom: 15,
    );

    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Future<void> _goToTheLake() async {}

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.cancel!),
        textTheme: Theme.of(context).textTheme,
        actions: [
          CustomButton(
            textColor: Theme.of(context).primaryColor,
            color: Theme.of(context).scaffoldBackgroundColor,
            textSize: 22,
          ),
        ],
      ),
      body: FadedSlideAnimation(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: GoogleMap(
                onTap: (LatLong) {},
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                    // bearing: 30,
                    target: LatLng(Provider.of<LocationProvider>(context).lat,
                        Provider.of<LocationProvider>(context).long),
                    //tilt: 45,
                    zoom: 4),
                compassEnabled: true,
                markers: Provider.of<LocationProvider>(context).listMarkers,
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/map_pin.png', scale: 5),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      Provider.of<LocationProvider>(context).address,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Spacer(),
                  isCard
                      ? InkWell(
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Theme.of(context).hintColor,
                          ),
                          onTap: () {
                            setState(() {
                              isCard = !isCard;
                            });
                          },
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
            isCard ? SaveAddressCard() : Container(),
            CustomButton(onTap: () {
              if (isCard == false) {
                setState(() {
                  isCard = true;
                });
              } else {
                Navigator.pop(context);
              }
            }),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

enum AddressType {
  Home,
  Office,
  Other,
}

AddressType selectedAddress = AddressType.Other;

class SaveAddressCard extends StatefulWidget {
  @override
  _SaveAddressCardState createState() => _SaveAddressCardState();
}

class _SaveAddressCardState extends State<SaveAddressCard> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: FadedSlideAnimation(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              locale.selectAddressType!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AddressTypeButton(
                  label: AppLocalizations.of(context)!.home,
                  icon: Icons.home,
                  onPressed: () {
                    setState(() {
                      selectedAddress = AddressType.Home;
                    });
                  },
                  isSelected: selectedAddress == AddressType.Home,
                ),
                AddressTypeButton(
                  label: AppLocalizations.of(context)!.office,
                  icon: Icons.business,
                  onPressed: () {
                    setState(() {
                      selectedAddress = AddressType.Office;
                    });
                  },
                  isSelected: selectedAddress == AddressType.Office,
                ),
                AddressTypeButton(
                  label: AppLocalizations.of(context)!.other,
                  icon: Icons.assistant,
                  onPressed: () {
                    setState(() {
                      selectedAddress = AddressType.Other;
                    });
                  },
                  isSelected: selectedAddress == AddressType.Other,
                ),
              ],
            ),
            EntryField(
              controller: _addressController,
              label: locale.enterAddressDetails,
              hint: locale.address,
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
