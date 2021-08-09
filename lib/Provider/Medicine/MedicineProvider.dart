


import 'dart:convert';

import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class LoginProvider with ChangeNotifier {
List<MedicineModel>medicineList=[];
  Future<void>SliderServices(String lang)async {
    var url=Config.base_url+"/api/sliders/get-sliders";
    var uri;
    print(url);
    var header={
      "lang":lang,
    };
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        medicineList= slideritems.map((e) => MedicineModel.fromJson(e)).toList();
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }

}

