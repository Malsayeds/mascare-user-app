


import 'dart:convert';
import 'package:doctoworld_user/Models/Medicine/CartItemModel.dart';
import 'package:doctoworld_user/Models/Medicine/ProductModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class CartProvider with ChangeNotifier {
  List productList=[];
  double total=0.0;
  int address_id=0;
  int successOrder=0;
  Future<void>setItems(List products)async {
    productList=products;
    notifyListeners();
  }
  void setTotal(double totalcount) {
    total=totalcount;
    notifyListeners();
  }
  void setAddressId(int address) {
    address_id=address;
    notifyListeners();
  }
  Future<void> makeOrder(int paymentMethod) async{
    String url=Config.base_url+"/order/medicine";
    print(url);
    var body={
      "medicines":productList,
      "total_amount": total,
      "patient_address_id": address_id,
      "payment_method_id": paymentMethod

    };
    print(body);
    var header=await Config.getHeaderWithjson();
    try{
      final responce=await http.post(Uri.parse(url),body:json.encode(body),headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        successOrder=responce.statusCode;
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }

}

