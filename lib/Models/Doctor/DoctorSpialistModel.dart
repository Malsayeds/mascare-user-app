// To parse this JSON data, do
//
//     final doctorSpialistModel = doctorSpialistModelFromJson(jsonString);

import 'dart:convert';

List<DoctorSpialistModel> doctorSpialistModelFromJson(String str) => List<DoctorSpialistModel>.from(json.decode(str).map((x) => DoctorSpialistModel.fromJson(x)));

String doctorSpialistModelToJson(List<DoctorSpialistModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorSpialistModel {
  DoctorSpialistModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  int id;
  String name;
  String icon;

  factory DoctorSpialistModel.fromJson(Map<String, dynamic> json) => DoctorSpialistModel(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}
