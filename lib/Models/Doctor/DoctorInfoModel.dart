// To parse this JSON data, do
//
//     final doctorInfoModel = doctorInfoModelFromJson(jsonString);

import 'dart:convert';

DoctorInfoModel doctorInfoModelFromJson(String str) => DoctorInfoModel.fromJson(json.decode(str));

String doctorInfoModelToJson(DoctorInfoModel data) => json.encode(data.toJson());

class DoctorInfoModel {
  DoctorInfoModel({
    required  this.singleDoctor,
    required   this.hotspitals,
    required   this.services,
  });

  SingleDoctor singleDoctor;
  List<Hotspital> hotspitals;
  List<Service> services;

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) => DoctorInfoModel(
    singleDoctor: SingleDoctor.fromJson(json["singleDoctor"]),
    hotspitals: List<Hotspital>.from(json["hotspitals"].map((x) => Hotspital.fromJson(x))),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "singleDoctor": singleDoctor.toJson(),
    "hotspitals": List<dynamic>.from(hotspitals.map((x) => x.toJson())),
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

class Hotspital {
  Hotspital({
    required  this.id,
    required  this.singleDoctorId,
    required  this.hospitalId,
    required  this.createdAt,
    required  this.updatedAt,
    required  this.hospital,
    required this.doctor,
  });

  int id;
  int singleDoctorId;
  int hospitalId;
  DateTime createdAt;
  DateTime updatedAt;
  Hospital hospital;
  Doctor doctor;

  factory Hotspital.fromJson(Map<String, dynamic> json) => Hotspital(
    id: json["id"],
    singleDoctorId: json["single_doctor_id"]??0,
    hospitalId: json["hospital_id"]??0,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    hospital: Hospital.fromJson(json["hospital"]),
    doctor: Doctor.fromJson(json["doctor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "single_doctor_id": singleDoctorId,
    "hospital_id": hospitalId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "hospital": hospital.toJson(),
    "doctor": doctor.toJson(),
  };
}

class Doctor {
  Doctor({
    required  this.id,
    required  this.bio,
    required  this.experience,
    required   this.contactNumber,
    required  this.qualification,
    required   this.fees,
    this.detailedAddress,
    this.about,
    required  this.createdAt,
    required  this.updatedAt,
    this.deletedAt,
    required  this.userId,
    required  this.areaId,
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
  DoctorUser user;

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
    areaId: json["area_id"]??0,
    user: DoctorUser.fromJson(json["user"]),
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
    "user": user.toJson(),
  };
}

class DoctorUser {
  DoctorUser({
    required  this.id,
    required  this.name,
    this.image,
    required  this.email,
  });

  int id;
  String name;
  dynamic image;
  String email;

  factory DoctorUser.fromJson(Map<String, dynamic> json) => DoctorUser(
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

class Hospital {
  Hospital({
    required   this.id,
    required    this.name,
    required   this.type,
    required   this.description,
    required   this.phone,
    required  this.createdAt,
    required  this.updatedAt,
    this.deletedAt,
    required   this.areaId,
    this.lng,
    this.lat,
    required    this.logo,
    required  this.area,
    required  this.media,
  });

  int id;
  String name;
  String type;
  String description;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int areaId;
  dynamic lng;
  dynamic lat;
  Logo logo;
  Area area;
  List<Logo> media;

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
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
    area: Area.fromJson(json["area"]),
    media: List<Logo>.from(json["media"].map((x) => Logo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "description": description,
    "phone": phone,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "area_id": areaId,
    "lng": lng,
    "lat": lat,
    "logo": logo.toJson(),
    "area": area.toJson(),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Area {
  Area({
    required  this.id,
    required  this.name,
    required  this.createdAt,
    required  this.updatedAt,
    this.deletedAt,
    required  this.cityId,
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
    cityId: json["city_id"] == null ? 0 : json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "city_id": cityId == null ? 0 : cityId,
  };
}

class Logo {
  Logo({
    required  this.id,
    required   this.modelType,
    required  this.modelId,
    required  this.uuid,
    required  this.collectionName,
    required  this.name,
    required   this.fileName,
    required  this.mimeType,
    required  this.disk,
    required  this.conversionsDisk,
    required this.size,
    required  this.manipulations,
    required this.customProperties,
    required this.responsiveImages,
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
    "model_type":modelType,
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

enum CollectionName { LOGO, ICON }


enum Type { PUBLIC }


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
    required  this.preview,
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

enum MimeType { IMAGE_PNG }



enum ModelType { APP_MODELS_HOSPITAL, APP_MODELS_SPECIFICATION }


class Service {
  Service({
    required  this.doctorId,
    required  this.serviceId,
    required   this.service,
  });

  int doctorId;
  int serviceId;
  List<Area> service;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    doctorId: json["doctor_id"],
    serviceId: json["service_id"],
    service: List<Area>.from(json["service"].map((x) => Area.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId,
    "service_id": serviceId,
    "service": List<dynamic>.from(service.map((x) => x.toJson())),
  };
}

class SingleDoctor {
  SingleDoctor({
    required  this.id,
    required  this.bio,
    required  this.experience,
    required  this.contactNumber,
    required  this.qualification,
    required  this.fees,
    this.detailedAddress,
    this.about,
    required  this.createdAt,
    required  this.updatedAt,
    this.deletedAt,
    required   this.userId,
    required   this.areaId,
    required   this.reviewsAvgRate,
    required   this.reviewsCount,
    required   this.user,
    required   this.specifications,
    required  this.area,
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
  var reviewsAvgRate;
  var reviewsCount;
  SingleDoctorUser user;
  List<Specification> specifications;
  Area area;

  factory SingleDoctor.fromJson(Map<String, dynamic> json) => SingleDoctor(
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
    areaId: json["area_id"]??0,
    reviewsAvgRate: json["reviews_avg_rate"],
    reviewsCount: json["reviews_count"],
    user: SingleDoctorUser.fromJson(json["user"]),
    specifications: List<Specification>.from(json["specifications"].map((x) => Specification.fromJson(x))),
    area: Area.fromJson(json["area"]),
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
    "specifications": List<dynamic>.from(specifications.map((x) => x.toJson())),
    "area": area.toJson(),
  };
}

class Specification {
  Specification({
    required  this.id,
    required   this.name,
    required   this.createdAt,
    required   this.updatedAt,
    required   this.deletedAt,
    required   this.icon,
    required   this.pivot,
    required   this.media,
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
    required  this.singleDoctorId,
    required this.specificationId,
  });

  int singleDoctorId;
  int specificationId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    singleDoctorId: json["single_doctor_id"],
    specificationId: json["specification_id"],
  );

  Map<String, dynamic> toJson() => {
    "single_doctor_id": singleDoctorId,
    "specification_id": specificationId,
  };
}

class SingleDoctorUser {
  SingleDoctorUser({
    required this.id,
    required this.name,
    required  this.email,
    this.emailVerifiedAt,
    this.gender,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic gender;
  dynamic image;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory SingleDoctorUser.fromJson(Map<String, dynamic> json) => SingleDoctorUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    gender: json["gender"],
    image: json["image"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "gender": gender,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}


