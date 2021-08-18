// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  AddressModel({
    required this.id,
    required  this.name,
    required this.detailedAddress,
    required this.phone,
    required this.lng,
    required this.lat,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.patientId,
    required this.areaId,
    required this.patient,
    required  this.area,
  });

  int id;
  String name;
  String detailedAddress;
  dynamic phone;
  String lng;
  String lat;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int patientId;
  int areaId;
  Patient patient;
  Area area;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    name: json["name"],
    detailedAddress: json["detailed_address"],
    phone: json["phone"],
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
    "phone": phone,
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
    required  this.name,
    required   this.createdAt,
    required   this.updatedAt,
    this.deletedAt,
    required this.cityId,
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
    required  this.age,
    required  this.contactNumber,
    this.diagnosis,
    required  this.createdAt,
    required   this.updatedAt,
    this.deletedAt,
    required  this.userId,
    this.areaId,
    required  this.user,
  });

  int id;
  int age;
  String contactNumber;
  dynamic diagnosis;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int userId;
  dynamic areaId;
  User user;

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
    user: User.fromJson(json["user"]),
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
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    this.image,
    required   this.email,
    this.gender,
  });

  int id;
  String name;
  dynamic image;
  String email;
  dynamic gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    email: json["email"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
    "gender": gender,
  };
}
