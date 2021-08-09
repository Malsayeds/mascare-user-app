// To parse this JSON data, do
//
//     final doctorSpialistModel = doctorSpialistModelFromJson(jsonString);

import 'dart:convert';

DoctorSpialistModel doctorSpialistModelFromJson(String str) => DoctorSpialistModel.fromJson(json.decode(str));

String doctorSpialistModelToJson(DoctorSpialistModel data) => json.encode(data.toJson());

class DoctorSpialistModel {
  DoctorSpialistModel({
    required this.doctorSpialistDetail,
  });

  List<DoctorSpialistDetail> doctorSpialistDetail;

  factory DoctorSpialistModel.fromJson(Map<String, dynamic> json) => DoctorSpialistModel(
    doctorSpialistDetail: List<DoctorSpialistDetail>.from(json["DoctorSpialistDetail"].map((x) => DoctorSpialistDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DoctorSpialistDetail": List<dynamic>.from(doctorSpialistDetail.map((x) => x.toJson())),
  };
}

class DoctorSpialistDetail {
  DoctorSpialistDetail({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory DoctorSpialistDetail.fromJson(Map<String, dynamic> json) => DoctorSpialistDetail(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
