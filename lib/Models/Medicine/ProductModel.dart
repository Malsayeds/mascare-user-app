// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

List<ProductDetailModel> productDetailModelFromJson(String str) => List<ProductDetailModel>.from(json.decode(str).map((x) => ProductDetailModel.fromJson(x)));

String productDetailModelToJson(List<ProductDetailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDetailModel {
  ProductDetailModel({
    required  this.id,
    required  this.name,
    required  this.price,
    required  this.packing,
    required this.category,
    required this.type,
    required this.manufacturer,
    required this.review,
    required  this.image,
  });

  int id;
  String name;
  String price;
  String packing;
  String category;
  String type;
  Manufacturer manufacturer;
  Review review;
  String image;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    packing: json["packing"],
    category: json["category"],
    type: json["type"],
    manufacturer: Manufacturer.fromJson(json["manufacturer"]),
    review: Review.fromJson(json["review"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "packing": packing,
    "category": category,
    "type": type,
    "manufacturer": manufacturer.toJson(),
    "review": review.toJson(),
    "image": image,
  };
}

class Manufacturer {
  Manufacturer({
    required this.name,
    required this.logo,
    required this.createdAt,
  });

  String name;
  dynamic logo;
  String createdAt;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    name: json["name"],
    logo: json["logo"],
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
    required this.count,
    required this.avg,
  });

  int count;
  double avg;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    count: json["count"],
    avg: json["avg"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "avg": avg,
  };
}
