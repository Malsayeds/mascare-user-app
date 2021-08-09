import 'dart:convert';

import 'package:doctoworld_user/Models/Doctor/DoctorModel.dart';
import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class DoctorProvider with ChangeNotifier {
  List<DoctorModel>doctorList=[];
  Future<void>getDoctorServices(String lang)async {
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
        //doctorList= slideritems.map((e) => DoctorModel.fromJson(e)).toList();
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }

}

