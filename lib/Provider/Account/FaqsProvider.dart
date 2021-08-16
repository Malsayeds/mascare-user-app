import 'dart:convert';
import 'package:doctoworld_user/Models/Account/FaqsModel.dart';
import 'package:doctoworld_user/Models/Medicine/MedicineModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class FaqsProvider with ChangeNotifier {
   List<FaqsDetail>FaqsList=[];
  Future<void>faqsServices()async {
    var url="${Config.base_url}/general/faqs?app_type=user";
    print(url);
    var header=await Config.getHeader();
    print(header);
    try
    {
      final response = await http.get(Uri.parse(url),headers:header);
       print(response.body);
       print("000000000000000000000000000000000000000000000");
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"];
        FaqsList= slideritems.map((e) => FaqsDetail.fromJson(e)).toList();
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }

}

