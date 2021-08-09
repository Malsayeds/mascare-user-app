import 'dart:convert';

import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class ContactProvider with ChangeNotifier {
  late Map<String,dynamic>contactInfo={"message":''};

  Future<void> contactServices(String email,String message) async{
    String url=Config.base_url+"/v1/doctor/contact-support";
    print(url);
    var body={
      "email" : email,
      "message" : message,
    };
    print(body);
    var header=await Config.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers:header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        contactInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }

}
