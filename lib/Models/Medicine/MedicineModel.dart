// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';



class MedicineModel {
  MedicineModel({
    required this.status,
    required this.message,
  });

  int status;
  String message;

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

