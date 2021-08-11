import 'dart:convert';

import 'package:doctoworld_user/Models/Doctor/DoctorModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorSpialistModel.dart';
import 'package:doctoworld_user/Models/Hospitals/HospitalsModel.dart';
import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class HospitalProvider with ChangeNotifier {
  List<HospitalsModel>hospitalslist=[];
  Future<void>getHospitals()async {
    var url=Config.base_url+"/hospitals";
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        hospitalslist= slideritems.map((e) => HospitalsModel.fromJson(e)).toList();
        print(hospitalslist.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}

