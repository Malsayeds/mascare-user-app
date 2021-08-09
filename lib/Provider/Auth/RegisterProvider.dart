import 'dart:convert';

import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class RegisterProvider with ChangeNotifier {
  late Map<String,dynamic>RegisterInfo;
  Future<void> RegisterServices(String first_name,String last_name,String email,String password,String phone) async{
    String url=Config.base_url+"/register";
    var body={
      "role_name" : "patient",
      "first_name" : first_name,
      "last_name":last_name,
      "email":email,
      "phone":phone,
      "password":password
    };
    try{
      final responce=await http.post(Uri.parse(url),body:body);
      if(responce.body.isNotEmpty)
      {
        RegisterInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }

}
