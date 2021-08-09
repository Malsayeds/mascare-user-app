import 'dart:convert';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class TermsCondionProvider with ChangeNotifier {
  late Map<String,dynamic>termsCondionInfo={"data":""};

  Future<void> termsCondionServices() async{
    String url=Config.base_url+"/v1/general/terms_conditions";
    var header=await Config.getHeader();
    try{
      final responce=await http.get(Uri.parse(url),headers: header);
      if(responce.body.isNotEmpty)
      {
        termsCondionInfo=json.decode(responce.body);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }

}
