import 'dart:convert';
import 'package:doctoworld_user/Models/Account/MyAppointmentModel.dart';
import 'package:doctoworld_user/Models/Adds/AddsModel.dart';
import 'package:doctoworld_user/Models/Doctor/AvailableTimeModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorInfoModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorModel.dart';
import 'package:doctoworld_user/Models/Doctor/DoctorSpialistModel.dart';
import 'package:doctoworld_user/Models/Doctor/SearchDoctorModel.dart';
import 'package:doctoworld_user/Models/Medicine/ProductModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class DoctorProvider with ChangeNotifier {

  List<DoctorSpialistModel>doctorSpeiaList=[];
  List<DoctorModel>doctors=[];
  late DoctorInfoModel doctorInfo;
 late AvailableTimeModel  times;
  bool isWishlist=true;
 int type=-1;
 int addToWishlist=0;
 int Selceted_doctor_id=0;
 List<DoctorModel>searchDoctorList=[];
late MyAppointmentModel myAppointment;
  late Map<String,dynamic>appointInfo;
  List<AddsDetail>addsList=[];
  int SelectedSpecialistId=0;
  String SelectedSpecialist="";
  void SetSelectedDoctor(int id){
    this.Selceted_doctor_id=id;
    notifyListeners();
    print(Selceted_doctor_id);
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
  }
  void SetSelectedSpecialist(int id,String name){
    this.SelectedSpecialistId=id;
    this.SelectedSpecialist=name;
    notifyListeners();
  }
  Future<void>getDoctorSpecialist(int type)async {
    var url=Config.base_url+"/specifications?type=$type";
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
    var url;
    if(id==0)
      url=Config.base_url+"/single-doctors";
     else
       url=Config.base_url+"/specification/${id}/doctors?type=$type";
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
  Future<void>addavailable(String date)async {
    var url=Config.base_url+"/single-appointments/${Selceted_doctor_id}/${date}";
    print(url);
    var header=await Config.getHeader();
    print(header);

    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      print("responcceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
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
  Future<bool>doctorWishlist()async {
    var url=Config.base_url+"/is-wishlisted/doctor/${Selceted_doctor_id}";
    print(url);
    var header=await Config.getHeader();
    print(header);

    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      print("responcceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(response.statusCode==200 && response.body!=null)
      {
        print(json.decode(response.body)["is_exists"]);
        isWishlist=json.decode(response.body)["is_exists"];
        notifyListeners();
      }
      return json.decode(response.body)["is_exists"];
    }
    catch(e)
    {
      print(e);
      return false;
    }
  }
  Future<void> getDoctInfo() async{
    String url=Config.base_url+"/single-doctors/${Selceted_doctor_id}";
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
    var body1={
      "name":key,
      "type":type.toString()
    };
    var body2={
      "name":key
    };
    var body=type==-1?body2:body1;
    print(body);
    var header=await Config.getHeader();
    try
    {
      final response = await http.post(Uri.parse(url),body: body,headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        searchDoctorList= slideritems.map((e) => DoctorModel.fromJson(e)).toList();
        print(searchDoctorList.length);
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>getFilterDoctor(int id,int fees_from,int fees_to,var gender,int rate_from,int rate_to)async {
    var url=Config.base_url+"/filter-doctors/$id";
    print(url);
    var body;
    if(gender=="gender"){
      body={
        "fees_from":fees_from.toString(),
        "fees_to":fees_to.toString(),
        "rate_from":rate_from.toString(),
        "rate_to":rate_to.toString()
      };
    }
    else{
      body={
        "fees_from":fees_from.toString(),
        "fees_to":fees_to.toString(),
        "gender":gender,
        "rate_from":rate_from.toString(),
        "rate_to":rate_to.toString()
      };
    }
    var header=await Config.getHeader();
    print(header);

    try
    {
      final response = await http.post(Uri.parse(url),body: body,headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        doctors= slideritems.map((e) => DoctorModel.fromJson(e)).toList();
        print(doctors.length);
        print("doctor_length");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void> addItemToWishlist(var single_medicine_id) async{
    String url=Config.base_url+"/doctor-wishlist";
    print(url);
    var body={
      "single_doctor_id" : single_medicine_id.toString(),
    };
    print(body);
    var header=await Config.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        addToWishlist=responce.statusCode;
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> deleteItemToWishlist() async{
    String url=Config.base_url+"/doctor-wishlist/${Selceted_doctor_id}";
    print(url);
    var header=await Config.getHeader();
    try{
      final responce=await http.delete(Uri.parse(url),headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        print(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void>getWishlist()async {
    var url=Config.base_url+"/doctor-wishlist";
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes));
        doctors= slideritems.map((e) => DoctorModel.fromJson(e)).toList();
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}

