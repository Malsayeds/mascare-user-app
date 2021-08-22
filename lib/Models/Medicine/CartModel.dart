// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  CartModel({
    required this.id,
    required this.medicine,
    required  this.quantity,
  });

  int id;
  Medicine medicine;
  int quantity;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    medicine: Medicine.fromJson(json["medicine"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "medicine": medicine.toJson(),
    "quantity": quantity,
  };
}

class Medicine {
  Medicine({
    required  this.id,
    required  this.name,
    required  this.description,
    required  this.price,
    required  this.packing,
    required  this.category,
    required this.type,
    required  this.image,
  });

  int id;
  String name;
  String description;
  String price;
  String packing;
  String category;
  String type;
  String image;

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    packing: json["packing"],
    category: json["category"],
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "packing": packing,
    "category": category,
    "type": type,
    "image": image,
  };
}
