// To parse this JSON data, do
//
//     final addsModel = addsModelFromJson(jsonString);

import 'dart:convert';

AddsModel addsModelFromJson(String str) => AddsModel.fromJson(json.decode(str));

String addsModelToJson(AddsModel data) => json.encode(data.toJson());

class AddsModel {
  AddsModel({
    required this.addsDetail,
  });

  List<AddsDetail> addsDetail;

  factory AddsModel.fromJson(Map<String, dynamic> json) => AddsModel(
    addsDetail: List<AddsDetail>.from(json["AddsDetail"].map((x) => AddsDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AddsDetail": List<dynamic>.from(addsDetail.map((x) => x.toJson())),
  };
}

class AddsDetail {
  AddsDetail({
    required  this.text,
    required  this.link,
    required   this.image,
    required  this.from,
    required  this.to,
    required   this.status,
  });

  String text;
  String link;
  String image;
  DateTime from;
  DateTime to;
  int status;

  factory AddsDetail.fromJson(Map<String, dynamic> json) => AddsDetail(
    text: json["text"],
    link: json["link"],
    image: json["image"],
    from: DateTime.parse(json["from"]),
    to: DateTime.parse(json["to"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "link": link,
    "image": image,
    "from": "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
    "to": "${to.year.toString().padLeft(4, '0')}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}",
    "status": status,
  };
}
