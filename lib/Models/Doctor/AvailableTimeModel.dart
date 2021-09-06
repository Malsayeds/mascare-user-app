// To parse this JSON data, do
//
//     final availableTimeModel = availableTimeModelFromJson(jsonString);

import 'dart:convert';

AvailableTimeModel availableTimeModelFromJson(String str) => AvailableTimeModel.fromJson(json.decode(str));

String availableTimeModelToJson(AvailableTimeModel data) => json.encode(data.toJson());

class AvailableTimeModel {
  AvailableTimeModel({
    required this.doctor,
    required this.availableTimeId,
    required this.availableTimes,
  });

  Doctor doctor;
  var availableTimeId;
  List<String> availableTimes;

  factory AvailableTimeModel.fromJson(Map<String, dynamic> json) => AvailableTimeModel(
    doctor: Doctor.fromJson(json["doctor"]),
    availableTimeId: json["available_time_id"],
    availableTimes: List<String>.from(json["availableTimes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "doctor": doctor.toJson(),
    "available_time_id": availableTimeId,
    "availableTimes": List<dynamic>.from(availableTimes.map((x) => x)),
  };
}

class Doctor {
  Doctor({
    required this.id,
    required this.bio,
    required this.experience,
    required this.contactNumber,
    required this.qualification,
    required this.fees,
    required this.detailedAddress,
    required this.about,
    required this.createdAt,
    required  this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.areaId,
    required  this.title,
    required  this.views,
    required this.isVerified,
    required this.hasCredentials,
    required this.approvedCoupons,
    required this.consultationFees,
    required  this.inhomeCheckup,
    required this.user,
  });

  int id;
  String bio;
  String experience;
  String contactNumber;
  String qualification;
  String fees;
  String detailedAddress;
  String about;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int userId;
  int areaId;
  String title;
  var views;
  var isVerified;
  var hasCredentials;
  var approvedCoupons;
  String consultationFees;
  var inhomeCheckup;
  User user;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    bio: json["bio"],
    experience: json["experience"],
    contactNumber: json["contact_number"],
    qualification: json["qualification"],
    fees: json["fees"],
    detailedAddress: json["detailed_address"],
    about: json["about"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    userId: json["user_id"],
    areaId: json["area_id"],
    title: json["title"],
    views: json["views"],
    isVerified: json["is_verified"],
    hasCredentials: json["has_credentials"],
    approvedCoupons: json["approved_coupons"],
    consultationFees: json["consultation_fees"],
    inhomeCheckup: json["inhome_checkup"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bio": bio,
    "experience": experience,
    "contact_number": contactNumber,
    "qualification": qualification,
    "fees": fees,
    "detailed_address": detailedAddress,
    "about": about,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "user_id": userId,
    "area_id": areaId,
    "title": title,
    "views": views,
    "is_verified": isVerified,
    "has_credentials": hasCredentials,
    "approved_coupons": approvedCoupons,
    "consultation_fees": consultationFees,
    "inhome_checkup": inhomeCheckup,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required  this.name,
    this.image,
    required this.email,
  });

  int id;
  String name;
  dynamic image;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    image: json["image"]??"",
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
  };
}
