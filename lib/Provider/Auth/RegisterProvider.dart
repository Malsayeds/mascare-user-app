import 'dart:convert';

import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class RegisterProvider with ChangeNotifier {
  late Map<String,dynamic>RegisterInfo;
  Future<void> RegisterServices(String name,String email,String password,String age,String contact_number,String language) async{
    String url=Config.base_url+"/register";
    print(url);
    var body={
      "role_name" : "Patient",
      "name" : name,
      "email":email,
      "password":password,
    // "password_confirmation":password,
      "age":age,
      "contact_number": contact_number,
      "language":language
    };
    print(body);
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
