import 'dart:convert';

import 'package:doctoworld_user/Models/Doctor/DoctorModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorSpialistModel.dart';
import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class DoctorSpeialistProvider with ChangeNotifier {

  List<DoctorSpialistDetail>doctorSpeiaList=[];
  List<DoctorDetail>doctors=[];
  int SelectedSpecialistId=0;
  String SelectedSpecialist="";
  void SetSelectedSpecialist(int id,String name){
    SelectedSpecialistId=id;
    this.SelectedSpecialist=name;
    notifyListeners();
  }
  Future<void>getDoctorSpecialist()async {
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
  Future<void>getDoctorBySpecialist()async {
    var url=Config.base_url+"/v1/user/specification/doctors?specification_id=${this.SelectedSpecialistId}";
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        doctors= slideritems.map((e) => DoctorDetail.fromJson(e)).toList();
        print(doctors.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}

