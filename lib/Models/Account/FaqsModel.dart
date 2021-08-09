// To parse this JSON data, do
//
//     final faqsModel = faqsModelFromJson(jsonString);

import 'dart:convert';

FaqsModel faqsModelFromJson(String str) => FaqsModel.fromJson(json.decode(str));

String faqsModelToJson(FaqsModel data) => json.encode(data.toJson());

class FaqsModel {
  FaqsModel({
    required this.faqsDetail,
  });

  List<FaqsDetail> faqsDetail;

  factory FaqsModel.fromJson(Map<String, dynamic> json) => FaqsModel(
    faqsDetail: List<FaqsDetail>.from(json["FaqsDetail"].map((x) => FaqsDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "FaqsDetail": List<dynamic>.from(faqsDetail.map((x) => x.toJson())),
  };
}

class FaqsDetail {
  FaqsDetail({
    required this.question,
    required this.answer,
  });

  String question;
  String answer;

  factory FaqsDetail.fromJson(Map<String, dynamic> json) => FaqsDetail(
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}
