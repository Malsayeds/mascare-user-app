


import 'dart:convert';

import 'package:doctoworld_user/Models/Medicine/CartModel.dart';
import 'package:doctoworld_user/Models/Medicine/CategoryModel.dart';
import 'package:doctoworld_user/Models/Medicine/PaymentMethodModel.dart';
import 'package:doctoworld_user/Models/Medicine/ProductModel.dart';
import 'package:doctoworld_user/Models/Medicine/ReviewModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
class ProductProvider with ChangeNotifier {
List<ProductDetailModel>productList=[];
List<ProductDetailModel>searchProductList=[];
List<CartModel>cartItem=[];
List<CategoryModel>CategoryList=[];
late ReviewsModel reviews;
Map<String,dynamic>UpdateCart={};
Map<String,dynamic>remove={};
int addWishlist=0;
List<PaymentMethodModel>paymentMethodList=[];
Future<void>getProductByCategory(int id)async {
    var url=Config.base_url+"/medicine-categories/$id";
    var uri;
    print(url);
    var header=await Config.getHeader();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["medicines"];
            productList= slideritems.map((e) => ProductDetailModel.fromJson(e)).toList();
            print(productList.length.toString()+"  lengthttttttttttttttttttttttttttttttttttttttttttttttttt");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
Future<void>getCategories()async {
  var url=Config.base_url+"/medicine-categories";
  print(url);
  var header=await Config.getHeader();
  try
  {
    final response = await http.get(Uri.parse(url),headers: header);
    print(response.body);
    if(response.statusCode==200 && response.body!=null)
    {
      List slideritems = json.decode(utf8.decode(response.bodyBytes));
      CategoryList= slideritems.map((e) => CategoryModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
  catch(e)
  {
    print(e);
  }
}
Future<void> addUpdateCart(var single_medicine_id,var quantity) async{
  String url=Config.base_url+"/cart";
  print(url);
  var body={
    "single_medicine_id" : single_medicine_id.toString(),
    "quantity" : quantity.toString(),
  };
  print(body);
  var header=await Config.getHeader();
  try{
    final responce=await http.post(Uri.parse(url),body:body,headers: header);
    print(responce.body);
    if(responce.body.isNotEmpty)
    {
      UpdateCart=json.decode(responce.body);
      notifyListeners();
    }
  }
  catch(e) {
    print(e.toString());
  }
}
Future<void> deleteFromCart(var id) async{
  String url=Config.base_url+"/cart/$id";
  print(url);
  var header=await Config.getHeader();
  try{
    final responce=await http.delete(Uri.parse(url),headers: header);
    print(responce.body);
    if(responce.body.isNotEmpty)
    {
      UpdateCart=json.decode(responce.body);
      notifyListeners();
    }
  }
  catch(e) {
    print(e.toString());
  }
}
Future<void>getCartItems()async {
  var url=Config.base_url+"/cart";
  print(url);
  var header=await Config.getHeader();
  try
  {
    final response = await http.get(Uri.parse(url),headers: header);
    if(response.statusCode==200 && response.body!=null)
    {
      List slideritems = json.decode(utf8.decode(response.bodyBytes));
      cartItem= slideritems.map((e) => CartModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
  catch(e)
  {
    print(e);
  }
}
Future<void>search(String name)async {
  var url=Config.base_url+"/search-medicine";
  print(url);
  var header=await Config.getHeader();
  var body={
    "name":name
  };
  try
  {
    final response = await http.post(Uri.parse(url),body: body,headers: header);
    print(response.body);
    if(response.statusCode==200 && response.body!=null)
    {
      List slideritems = json.decode(utf8.decode(response.bodyBytes));
      searchProductList= slideritems.map((e) => ProductDetailModel.fromJson(e)).toList();
      print(searchProductList.length.toString()+"  lengthttttttttttttttttttttttttttttttttttttttttttttttttt");
      notifyListeners();
    }
  }
  catch(e)
  {
    print(e);
  }
}
Future<void> addItemToWishlist(var single_medicine_id) async{
  String url=Config.base_url+"/wishlist";
  print(url);
  var body={
    "single_medicine_id" : single_medicine_id.toString(),
  };
  print(body);
  var header=await Config.getHeader();
  try{
    final responce=await http.post(Uri.parse(url),body:body,headers: header);
    print(responce.body);
    if(responce.body.isNotEmpty)
    {
      addWishlist=responce.statusCode;
      notifyListeners();
    }
  }
  catch(e) {
    print(e.toString());
  }
}
Future<void>getWishlist()async {
  var url=Config.base_url+"/wishlist";
  print(url);
  var header=await Config.getHeader();
  try
  {
    final response = await http.get(Uri.parse(url),headers: header);
    print(response.body);
    if(response.statusCode==200 && response.body!=null)
    {
      List slideritems = json.decode(utf8.decode(response.bodyBytes));
      productList= slideritems.map((e) => ProductDetailModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
  catch(e)
  {
    print(e);
  }
}
Future<void>getReviews(int id)async {
  var url=Config.base_url+"/medicine/${id}/reviews";
  print(url);
  var header=await Config.getHeader();
  try
  {
    final response = await http.get(Uri.parse(url),headers: header);
    print(response.body);
    if(response.statusCode==200 && response.body!=null)
    {
      reviews=ReviewsModel.fromJson(json.decode(response.body)["medicine"]);
      print(reviews);
      notifyListeners();
    }
  }
  catch(e)
  {
    print(e);
  }
}
Future<void>getPaymentMethod()async {
  var url=Config.base_url+"/payment-methods";
  print(url);
  var header=await Config.getHeader();
  try
  {
    final response = await http.get(Uri.parse(url),headers: header);
    if(response.statusCode==200 && response.body!=null)
    {
      List slideritems = json.decode(utf8.decode(response.bodyBytes));
      paymentMethodList= slideritems.map((e) => PaymentMethodModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
  catch(e)
  {
    print(e);
  }
}

}

