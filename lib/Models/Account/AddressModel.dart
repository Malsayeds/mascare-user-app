// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  AddressModel({
    required  this.id,
    required  this.name,
    required   this.detailedAddress,
    required   this.phone,
    required   this.lng,
    required    this.lat,
    required    this.createdAt,
    required      this.updatedAt,
    required      this.deletedAt,
    required this.patientId,
    required  this.areaId,
    required   this.patient,
    required   this.area,
  });

  int id;
  String? name;
  String? detailedAddress;
  String? phone;
  String? lng;
  String? lat;
  DateTime createdAt;
  DateTime updatedAt;
  String? deletedAt;
  int patientId;
  int areaId;
  Patient patient;
  Area area;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    name: json["name"],
    detailedAddress: json["detailed_address"],
    phone: json["phone"] == null ? null : json["phone"],
    lng: json["lng"],
    lat: json["lat"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    patientId: json["patient_id"],
    areaId: json["area_id"],
    patient: Patient.fromJson(json["patient"]),
    area: Area.fromJson(json["area"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "detailed_address": detailedAddress,
    "phone": phone == null ? null : phone,
    "lng": lng,
    "lat": lat,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "patient_id": patientId,
    "area_id": areaId,
    "patient": patient.toJson(),
    "area": area.toJson(),
  };
}

class Area {
  Area({
    required  this.id,
    required this.name,
    required   this.createdAt,
    required  this.updatedAt,
    required  this.deletedAt,
    required  this.cityId,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int cityId;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "city_id": cityId,
  };
}

class Patient {
  Patient({
    required this.id,
    required this.age,
    required this.contactNumber,
    required this.diagnosis,
    required this.createdAt,
    required this.updatedAt,
    required  this.deletedAt,
    required  this.userId,
    required  this.areaId,
  });

  int id;
  int age;
  String contactNumber;
  String diagnosis;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int userId;
  int areaId;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    age: json["age"],
    contactNumber: json["contact_number"],
    diagnosis: json["diagnosis"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    userId: json["user_id"],
    areaId: json["area_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": age,
    "contact_number": contactNumber,
    "diagnosis": diagnosis,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "user_id": userId,
    "area_id": areaId,
  };
}
