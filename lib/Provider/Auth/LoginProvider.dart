import 'dart:convert';

import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class LoginProvider with ChangeNotifier {
late Map<String,dynamic>LoginInfo;

 Future<void> LoginServices(String email,String password) async{
    String url=Config.base_url+"/login";
    print(url);
    var body={
      "email" : email,
      "password" : password,
      "role_name":"patient"
    };
    print(body);
    try{
      final responce=await http.post(Uri.parse(url),body:body);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        LoginInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }

}
