// To parse this JSON data, do
//
//     final doctorInfoModel = doctorInfoModelFromJson(jsonString);

import 'dart:convert';

DoctorInfoModel doctorInfoModelFromJson(String str) => DoctorInfoModel.fromJson(json.decode(str));

String doctorInfoModelToJson(DoctorInfoModel data) => json.encode(data.toJson());

class DoctorInfoModel {
  DoctorInfoModel({
    required this.singleDoctor,
    required  this.hospitals,
    required  this.services,
  });

  SingleDoctor singleDoctor;
  List<dynamic> hospitals;
  List<DoctorInfoModelService> services;

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) => DoctorInfoModel(
    singleDoctor: SingleDoctor.fromJson(json["singleDoctor"]),
    hospitals: List<dynamic>.from(json["hospitals"].map((x) => x)),
    services: List<DoctorInfoModelService>.from(json["services"].map((x) => DoctorInfoModelService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "singleDoctor": singleDoctor.toJson(),
    "hospitals": List<dynamic>.from(hospitals.map((x) => x)),
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

class DoctorInfoModelService {
  DoctorInfoModelService({
    required  this.doctorId,
    required this.serviceId,
    required this.fees,
    required this.service,
  });

  int doctorId;
  int serviceId;
  String fees;
  List<ServiceService> service;

  factory DoctorInfoModelService.fromJson(Map<String, dynamic> json) => DoctorInfoModelService(
    doctorId: json["doctor_id"],
    serviceId: json["service_id"],
    fees: json["fees"],
    service: List<ServiceService>.from(json["service"].map((x) => ServiceService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "service_id": serviceId,
    "fees": fees,
    "service": List<dynamic>.from(service.map((x) => x.toJson())),
  };
}

class ServiceService {
  ServiceService({
    required  this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory ServiceService.fromJson(Map<String, dynamic> json) => ServiceService(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class SingleDoctor {
  SingleDoctor({
    required  this.id,
    required  this.name,
    required this.contactNumber,
    required this.image,
    required this.address,
    required  this.fees,
    required  this.experience,
    required this.bio,
    required this.qualification,
    required this.reviewsAvgRate,
    required this.reviewsCount,
    required this.specifications,
  });

  int id;
  String name;
  String contactNumber;
  String image;
  String address;
  int fees;
  String experience;
  String bio;
  String qualification;
  double reviewsAvgRate;
  int reviewsCount;
  List<Specification> specifications;

  factory SingleDoctor.fromJson(Map<String, dynamic> json) => SingleDoctor(
    id: json["id"],
    name: json["name"],
    contactNumber: json["contact_number"],
    image: json["image"],
    address: json["address"],
    fees: json["fees"],
    experience: json["experience"],
    bio: json["bio"],
    qualification: json["qualification"],
    reviewsAvgRate: json["reviews_avg_rate"].toDouble(),
    reviewsCount: json["reviews_count"],
    specifications: List<Specification>.from(json["specifications"].map((x) => Specification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "contact_number": contactNumber,
    "image": image,
    "address": address,
    "fees": fees,
    "experience": experience,
    "bio": bio,
    "qualification": qualification,
    "reviews_avg_rate": reviewsAvgRate,
    "reviews_count": reviewsCount,
    "specifications": List<dynamic>.from(specifications.map((x) => x.toJson())),
  };
}

class Specification {
  Specification({
    required this.id,
    required this.name,
    required  this.icon,
  });

  int id;
  String name;
  String icon;

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
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
