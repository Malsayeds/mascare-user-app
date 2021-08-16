import 'dart:convert';

import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class AddressesProvider with ChangeNotifier {
  late Map<String,dynamic>addAddressInfo;

  Future<void> addAddress(String name,String detailed_address,int area_id,double long,double lat) async{
    String url=Config.base_url+"/patient-addresses";
    print(url);
    var body={
      "name" : name,
      "detailed_address" : detailed_address,
      "area_id":area_id,
      "lng":long,
      "lat":lat,
    };
    print(body);
    try{
      final responce=await http.post(Uri.parse(url),body:body);
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

}
