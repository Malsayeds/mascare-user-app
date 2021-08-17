import 'dart:convert';
import 'package:doctoworld_user/Models/Account/MyAppointmentModel.dart';
import 'package:doctoworld_user/Models/Adds/AddsModel.dart';
import 'package:doctoworld_user/Models/Doctor/AvailableTimeModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorInfoModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorSpialistModel.dart';
import 'package:doctoworld_user/Models/Doctor/SearchDoctorModel.dart';
import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class DoctorProvider with ChangeNotifier {

  List<DoctorSpialistModel>doctorSpeiaList=[];
  List<DoctorModel>doctors=[];
  late DoctorInfoModel doctorInfo;
 late AvailableTimeModel  times;
 List<SearchDoctorModel>searchDoctorList=[];
late MyAppointmentModel myAppointment;
  late Map<String,dynamic>appointInfo;
  List<AddsDetail>addsList=[];
  int SelectedSpecialistId=0;
  String SelectedSpecialist="";
  void SetSelectedSpecialist(int id,String name){
    this.SelectedSpecialistId=id;
    this.SelectedSpecialist=name;
    notifyListeners();
  }
  Future<void>getDoctorSpecialist()async {
    var url=Config.base_url+"/specifications";
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        doctorSpeiaList = slideritems.map((e) => DoctorSpialistModel.fromJson(e)).toList();
        print(doctorSpeiaList.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>getDoctorBySpecialist(int id)async {
    var url=Config.base_url+"/specification/${id}/doctors";
    print(url);
    var header=await Config.getHeader();
    print(header);

    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        doctors= slideritems.map((e) => DoctorModel.fromJson(e)).toList();
        print(doctors.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>addavailable(int doctor_id,String date)async {
    print("ssssssssssssssssssssssss");
    var url=Config.base_url+"/single-appointments/${doctor_id}/${date}";
    print(url);
    print("ddddddddddddddddddddddddddddddddddddddddddddd");
    var header=await Config.getHeader();
    print(header);

    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        times=AvailableTimeModel.fromJson(json.decode(response.body));
        print(times);
        print("available eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void> getDoctInfo(int doctor_id) async{
    String url=Config.base_url+"/single-doctors/${doctor_id}";
    print(url);
   var header= await Config.getHeader();
    try{
      final responce=await http.get(Uri.parse(url),headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        doctorInfo=DoctorInfoModel.fromJson(json.decode(responce.body));
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> addAppointMent(String doctor_id,String time,String date,int available_time_id,String notes) async{
    String url=Config.base_url+"/single-appointments";
    print(url);
    print(url);
    var body={
      "doctor_id" : doctor_id,
      "time" : time,
      "date":date,
      "available_time_id":available_time_id.toString(),
      "notes":notes
    };
    print(body);
   var header=await await Config.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        appointInfo=json.decode(responce.body);
        print(appointInfo);
        print("dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> getMyAppointMent() async{
    String url=Config.base_url+"/single-appointments";
    print(url);
    var header= await Config.getHeader();
    try{
      final responce=await http.get(Uri.parse(url),headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        myAppointment=MyAppointmentModel.fromJson(json.decode(responce.body));
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void>getDoctorAdds()async {
    var url=Config.base_url+"/ads";
    var uri;
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        addsList= slideritems.map((e) => AddsDetail.fromJson(e)).toList();
        print(addsList.length);
        print("ssssssssssssssssssssssssssssssssssss");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>seachDoctor(String key)async {
    var url=Config.base_url+"/search-doctors";
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
        searchDoctorList= slideritems.map((e) => SearchDoctorModel.fromJson(e)).toList();
        print(searchDoctorList.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}

