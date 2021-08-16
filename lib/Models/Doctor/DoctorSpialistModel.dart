// To parse this JSON data, do
//
//     final doctorSpialistModel = doctorSpialistModelFromJson(jsonString);

import 'dart:convert';

List<DoctorSpialistModel> doctorSpialistModelFromJson(String str) => List<DoctorSpialistModel>.from(json.decode(str).map((x) => DoctorSpialistModel.fromJson(x)));

String doctorSpialistModelToJson(List<DoctorSpialistModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorSpialistModel {
  DoctorSpialistModel({
    required this.id,
    required  this.name,
    required  this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required  this.icon,
    required  this.media,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  var icon;
  List<Icon> media;

  factory DoctorSpialistModel.fromJson(Map<String, dynamic> json) => DoctorSpialistModel(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
    media: List<Icon>.from(json["media"].map((x) => Icon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "icon": icon == null ? null : icon.toJson(),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Icon {
  Icon({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.uuid,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required  this.mimeType,
    required  this.disk,
    required this.conversionsDisk,
    required this.size,
    required  this.manipulations,
    required this.customProperties,
    required  this.responsiveImages,
    required  this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required  this.thumbnail,
    required  this.preview,
  });

  int id;
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  List<dynamic> manipulations;
  CustomProperties customProperties;
  List<dynamic> responsiveImages;
  int orderColumn;
  DateTime createdAt;
  DateTime updatedAt;
  String url;
  String thumbnail;
  String preview;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
    id: json["id"],
    modelType: json["model_type"],
    modelId: json["model_id"],
    uuid: json["uuid"],
    collectionName: json["collection_name"],
    name: json["name"],
    fileName: json["file_name"],
    mimeType: json["mime_type"],
    disk: json["disk"],
    conversionsDisk: json["conversions_disk"],
    size: json["size"],
    manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
    customProperties: CustomProperties.fromJson(json["custom_properties"]),
    responsiveImages: List<dynamic>.from(json["responsive_images"].map((x) => x)),
    orderColumn: json["order_column"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    url: json["url"],
    thumbnail: json["thumbnail"],
    preview: json["preview"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "model_type": modelType,
    "model_id": modelId,
    "uuid": uuid,
    "collection_name": collectionName,
    "name": name,
    "file_name": fileName,
    "mime_type": mimeType,
    "disk": disk,
    "conversions_disk": conversionsDisk,
    "size": size,
    "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
    "custom_properties": customProperties.toJson(),
    "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
    "order_column": orderColumn,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "url": url,
    "thumbnail": thumbnail,
    "preview": preview,
  };
}

class CustomProperties {
  CustomProperties({
    required  this.generatedConversions,
  });

  GeneratedConversions generatedConversions;

  factory CustomProperties.fromJson(Map<String, dynamic> json) => CustomProperties(
    generatedConversions: GeneratedConversions.fromJson(json["generated_conversions"]),
  );

  Map<String, dynamic> toJson() => {
    "generated_conversions": generatedConversions.toJson(),
  };
}

class GeneratedConversions {
  GeneratedConversions({
    required  this.thumb,
    required   this.preview,
  });

  bool thumb;
  bool preview;

  factory GeneratedConversions.fromJson(Map<String, dynamic> json) => GeneratedConversions(
    thumb: json["thumb"],
    preview: json["preview"],
  );

  Map<String, dynamic> toJson() => {
    "thumb": thumb,
    "preview": preview,
  };
}
