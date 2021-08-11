// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

DoctorModel doctorModelFromJson(String str) => DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  DoctorModel({
    required this.doctorDetail,
  });

  List<DoctorDetail> doctorDetail;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    doctorDetail: List<DoctorDetail>.from(json["DoctorDetail"].map((x) => DoctorDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DoctorDetail": List<dynamic>.from(doctorDetail.map((x) => x.toJson())),
  };
}

class DoctorDetail {
  DoctorDetail({
    required this.doctor,
    required this.review,
    required this.totalRatedPeople,
  });

  Doctor doctor;
  double review;
  int totalRatedPeople;

  factory DoctorDetail.fromJson(Map<String, dynamic> json) => DoctorDetail(
    doctor: Doctor.fromJson(json["doctor"]),
    review: json["review"].toDouble(),
    totalRatedPeople: json["total_rated_people"],
  );

  Map<String, dynamic> toJson() => {
    "doctor": doctor.toJson(),
    "review": review,
    "total_rated_people": totalRatedPeople,
  };
}

class Doctor {
  Doctor({
    required this.name,
    required this.fees,
    required this.exp,
    required this.img,
  });

  String name;
  int fees;
  String exp;
  String img;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    name: json["name"],
    fees: json["fees"],
    exp: json["exp"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "fees": fees,
    "exp": exp,
    "img": img,
  };
}
