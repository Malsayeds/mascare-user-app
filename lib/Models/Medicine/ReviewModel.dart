// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromJson(jsonString);

import 'dart:convert';

ReviewsModel reviewsModelFromJson(String str) => ReviewsModel.fromJson(json.decode(str));

String reviewsModelToJson(ReviewsModel data) => json.encode(data.toJson());

class ReviewsModel {
  ReviewsModel({
    required this.name,
    required  this.manufacturer,
    required this.reviews,
    required this.avg,
    required this.count,
  });

  String name;
  Manufacturer manufacturer;
  List<Review> reviews;
  double avg;
  int count;

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
    name: json["name"],
    manufacturer: Manufacturer.fromJson(json["manufacturer"]),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    avg: json["avg"].toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "manufacturer": manufacturer.toJson(),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "avg": avg,
    "count": count,
  };
}

class Manufacturer {
  Manufacturer({
    required this.name,
    required this.logo,
    required this.createdAt,
  });

  String name;
  String logo;
  String createdAt;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    name: json["name"],
    logo: json["logo"]??"",
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logo": logo,
    "created_at": createdAt,
  };
}

class Review {
  Review({
    required  this.username,
    required this.image,
    required this.review,
    required this.rate,
    required this.date,
  });

  String username;
  String image;
  String review;
  int rate;
  String date;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    username: json["username"],
    image: json["image"]??"",
    review: json["review"],
    rate: json["rate"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "image": image,
    "review": review,
    "rate": rate,
    "date": date,
  };
}
