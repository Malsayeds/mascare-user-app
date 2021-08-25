// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

List<DoctorModel> doctorModelFromJson(String str) => List<DoctorModel>.from(json.decode(str).map((x) => DoctorModel.fromJson(x)));

String doctorModelToJson(List<DoctorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorModel {
  DoctorModel({
    required this.id,
    required this.bio,
    required this.exprience,
    required this.contactNumber,
    required this.qualtification,
    required this.fees,
    this.detailedAddress,
    this.about,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.areaId,
    required this.reviewsCount,
    required this.reviewsAvgRate,
    required this.user,
  });

  int id;
  String bio;
  String exprience;
  String contactNumber;
  String qualtification;
  String fees;
  dynamic? detailedAddress;
  dynamic? about;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic? deletedAt;
  int userId;
  dynamic? areaId;
  int reviewsCount;
  var reviewsAvgRate;
  User user;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    id: json["id"],
    bio: json["bio"]??"",
    exprience: json["exprience"]??"",
    contactNumber: json["contact_number"]??"",
    qualtification: json["qualtification"]??"",
    fees: json["fees"],
    detailedAddress: json["detailed_address"]??"",
    about: json["about"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"]??"",
    userId: json["user_id"],
    areaId: json["area_id"]??0,
    reviewsCount: json["reviews_count"],
    reviewsAvgRate:json["reviews_avg_rate"]==null? 0.0:json["reviews_avg_rate"].toDouble(),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bio": bio,
    "exprience": exprience,
    "contact_number": contactNumber,
    "qualtification": qualtification,
    "fees": fees,
    "detailed_address": detailedAddress,
    "about": about,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "user_id": userId,
    "area_id": areaId,
    "reviews_count": reviewsCount,
    "reviews_avg_rate": reviewsAvgRate,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    this.image,
    required this.email,
  });

  int id;
  String name;
  dynamic image;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"]??"",
    image: json["image"]??"",
    email: json["email"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
  };
}
