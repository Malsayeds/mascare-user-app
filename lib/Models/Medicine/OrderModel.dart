// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    required this.id,
    required this.date,
    required this.total,
    required this.address,
    required this.status,
    required this.medicines,
  });
  int id;
  String date;
  String total;
  Address address;
  Status status;
  List<Medicine> medicines;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    date: json["date"],
    total: json["total"],
    address: Address.fromJson(json["address"]),
    status: Status.fromJson(json["status"]),
    medicines: List<Medicine>.from(json["medicines"].map((x) => Medicine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "total": total,
    "address": address.toJson(),
    "status": status.toJson(),
    "medicines": List<dynamic>.from(medicines.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    required  this.name,
    required this.detailedAddress,
  });

  String name;
  String detailedAddress;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    name: json["name"],
    detailedAddress: json["detailed_address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "detailed_address": detailedAddress,
  };
}

class Medicine {
  Medicine({
    required this.id,
    required this.name,
    required  this.packing,
    required  this.price,
    required this.quantity,
  });

  int id;
  String name;
  String packing;
  int price;
  int quantity;

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    id: json["id"],
    name: json["name"],
    packing: json["packing"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "packing": packing,
    "price": price,
    "quantity": quantity,
  };
}

class Status {
  Status({
    required  this.id,
    required  this.name,
  });

  int id;
  String name;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
