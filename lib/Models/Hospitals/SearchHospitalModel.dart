// To parse this JSON data, do
//
//     final searchHospitalModel = searchHospitalModelFromJson(jsonString);

import 'dart:convert';

List<SearchHospitalModel> searchHospitalModelFromJson(String str) => List<SearchHospitalModel>.from(json.decode(str).map((x) => SearchHospitalModel.fromJson(x)));

String searchHospitalModelToJson(List<SearchHospitalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchHospitalModel {
  SearchHospitalModel({
    required  this.id,
    required  this.name,
    required this.type,
    required this.description,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.areaId,
    this.lng,
    this.lat,
    required this.logo,
    required this.specifications,
    required this.media,
  });

  int id;
  String name;
  var type;
  String description;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int areaId;
  dynamic lng;
  dynamic lat;
  Logo logo;
  List<Specification> specifications;
  List<Logo> media;

  factory SearchHospitalModel.fromJson(Map<String, dynamic> json) => SearchHospitalModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    description: json["description"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    areaId: json["area_id"],
    lng: json["lng"],
    lat: json["lat"],
    logo: Logo.fromJson(json["logo"]),
    specifications: List<Specification>.from(json["specifications"].map((x) => Specification.fromJson(x))),
    media: List<Logo>.from(json["media"].map((x) => Logo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type ,
    "description": description,
    "phone": phone,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "area_id": areaId,
    "lng": lng,
    "lat": lat,
    "logo": logo.toJson(),
    "specifications": List<dynamic>.from(specifications.map((x) => x.toJson())),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Logo {
  Logo({
    required this.id,
    required  this.modelType,
    required  this.modelId,
    required   this.uuid,
    required  this.collectionName,
    required  this.name,
    required  this.fileName,
    required  this.mimeType,
    required  this.disk,
    required  this.conversionsDisk,
    required this.size,
    required this.manipulations,
    required  this.customProperties,
    required  this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required  this.url,
    required  this.thumbnail,
    required  this.preview,
  });

  int id;
  var modelType;
  int modelId;
  String uuid;
  var collectionName;
  String name;
  String fileName;
  var mimeType;
  var disk;
  var conversionsDisk;
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

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
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
    "disk":disk,
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
    required this.generatedConversions,
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
    required this.thumb,
    required this.preview,
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





class Specification {
  Specification({
    required this.id,
    required  this.name,
    required  this.createdAt,
    required  this.updatedAt,
    this.deletedAt,
    required  this.icon,
    required  this.pivot,
    required  this.media,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Logo icon;
  Pivot pivot;
  List<Logo> media;

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    icon: Logo.fromJson(json["icon"]),
    pivot: Pivot.fromJson(json["pivot"]),
    media: List<Logo>.from(json["media"].map((x) => Logo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "icon": icon.toJson(),
    "pivot": pivot.toJson(),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Pivot {
  Pivot({
    required this.hospitalId,
    required this.specificationId,
  });

  int hospitalId;
  int specificationId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    hospitalId: json["hospital_id"],
    specificationId: json["specification_id"],
  );

  Map<String, dynamic> toJson() => {
    "hospital_id": hospitalId,
    "specification_id": specificationId,
  };
}


