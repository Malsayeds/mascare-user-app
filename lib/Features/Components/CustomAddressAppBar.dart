import 'package:doctoworld_user/Features/Components/CustomCartIcon.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/LocationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAddressAppBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<CustomAddressAppBar>{
  getCurrentLoctaion()async{
    var locationProvider= Provider.of<LocationProvider>(context, listen: false);
    await locationProvider.getCurrentLocation();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLoctaion();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var locationProvider= Provider.of<LocationProvider>(context, listen: true);
    return locationProvider.address=="Current Location"?
    InkWell(
    onTap: ()=>getCurrentLoctaion()
    ,child: Text("Set Current Loction",style: TextStyle(color: Colors.black,fontSize: 14)))
    :Text(locationProvider.address.substring(5),style: TextStyle(color: Colors.black,fontSize: 14)
    );
  }
}