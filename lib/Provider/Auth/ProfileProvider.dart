import 'dart:convert';

import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class ProfileProvider with ChangeNotifier{
  late Map<String,dynamic>getProfileInfo={"id":""};
  late Map<String,dynamic>updateProfileInfo;
  Future<void> GetProfileServices() async{
    String url=Config.base_url+"/profile";
    print(url);
    var header=await Config.getHeader();
    print(header);
    try{
      final responce=await http.get(Uri.parse(url),headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        getProfileInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> logout() async{
    String url=Config.base_url+"/logout";
    print(url);
    var header=await Config.getHeader();
    print(header);
    try{
      final responce=await http.post(Uri.parse(url),headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        getProfileInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> UpdateProfileServices(String email,String password) async{
    String url=Config.base_url+"/api/people/login";
    print(url);
    var body={
      "emial" : email,
      "password" : password,
    };
    var header={
      "Content-Type":"application/json",
    };
    print(header);
    try{
      final responce=await http.post(Uri.parse(url),body:json.encode(body),headers: header);
      if(responce.body.isNotEmpty)
      {
        updateProfileInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> changelanguage(String lang) async{
    String url=Config.base_url+"/change-language";
    print(url);
    var body={
      "language" : lang,
    };
    var header=await Config.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        updateProfileInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
}
