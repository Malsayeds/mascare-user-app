// To parse this JSON data, do
//
//     final searchDoctorModel = searchDoctorModelFromJson(jsonString);

import 'dart:convert';

List<SearchDoctorModel> searchDoctorModelFromJson(String str) => List<SearchDoctorModel>.from(json.decode(str).map((x) => SearchDoctorModel.fromJson(x)));

String searchDoctorModelToJson(List<SearchDoctorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchDoctorModel {
  SearchDoctorModel({
    required this.id,
    required this.bio,
    required this.experience,
    required  this.contactNumber,
    required this.qualification,
    required  this.fees,
    this.detailedAddress,
    this.about,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required  this.userId,
    required this.areaId,
    required  this.reviewsAvgRate,
    required  this.reviewsCount,
    required  this.user,
  });

  int id;
  String bio;
  String experience;
  String contactNumber;
  String qualification;
  String fees;
  dynamic detailedAddress;
  dynamic about;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int userId;
  int areaId;
  double reviewsAvgRate;
  int reviewsCount;
  User user;

  factory SearchDoctorModel.fromJson(Map<String, dynamic> json) => SearchDoctorModel(
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
    reviewsAvgRate: json["reviews_avg_rate"].toDouble(),
    reviewsCount: json["reviews_count"],
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
    "reviews_avg_rate": reviewsAvgRate,
    "reviews_count": reviewsCount,
    "user": user.toJson(),
  };
}

class User {
  User({
    required  this.id,
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
    name: json["name"],
    image: json["image"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
  };
}
