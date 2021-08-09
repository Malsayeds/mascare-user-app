import 'package:doctoworld_user/Stroage/DbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocode;

class GlobalProvider with ChangeNotifier {
  int  counter = 0;
  int getCounter(){
    return this.counter;
  }
  Future<void>setcounter()async{
    DbHelper db =new DbHelper();
   List dataLocal=await db.allProduct();
   this.counter =dataLocal.length;
   notifyListeners();
  }
  void updateCounter(){
    this.counter+=1;
    notifyListeners();
  }
}
