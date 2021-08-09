import 'dart:convert';

import 'package:doctoworld_user/Models/Doctor/DoctorSpialistModel.dart';
import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class DoctorSpeialistProvider with ChangeNotifier {

  List<DoctorSpialistDetail>doctorSpeiaList=[];
  Future<void>SliderServices(String lang)async {
    var url=Config.base_url+"/v1/user/specification";
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        doctorSpeiaList= slideritems.map((e) => DoctorSpialistDetail.fromJson(e)).toList();
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }

}

