import 'dart:convert';

import 'package:doctoworld_user/Models/Doctor/DoctorModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorSpialistModel.dart';
import 'package:doctoworld_user/Models/Hospitals/HospitalsModel.dart';
import 'package:doctoworld_user/Models/Hospitals/SearchHospitalModel.dart';
import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class HospitalProvider with ChangeNotifier {
  List<HospitalsModel>hospitalslist=[];
  List<HospitalsModel> searchHospitalslist=[];
  List<DoctorModel>doctorsList=[];
  Future<void>getHospitals(double long,double lat)async {
    var url=Config.base_url+"/hospitals?lng=$long&lat=$lat";
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
  Future<void>seachHospitals(String key)async {
    var url=Config.base_url+"/search-hospitals";
    print(url);
    var body={
      "key-name":key
    };
    print(body);
    var header=await Config.getHeader();
    try
    {
      final response = await http.post(Uri.parse(url),body: body,headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        searchHospitalslist= slideritems.map((e) => HospitalsModel.fromJson(e)).toList();
        print(searchHospitalslist.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  ///get-doctors/4
  Future<void>getDoctorBySpecificationId(var id)async {
    var url=Config.base_url+"/get-doctors/$id";
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        doctorsList= slideritems.map((e) => DoctorModel.fromJson(e)).toList();
        print(doctorsList.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}

