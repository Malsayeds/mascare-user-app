// To parse this JSON data, do
//
//     final myAppointmentModel = myAppointmentModelFromJson(jsonString);

import 'dart:convert';

MyAppointmentModel myAppointmentModelFromJson(String str) => MyAppointmentModel.fromJson(json.decode(str));

String myAppointmentModelToJson(MyAppointmentModel data) => json.encode(data.toJson());

class MyAppointmentModel {
  MyAppointmentModel({
    required this.pastAppointments,
    required this.commingAppointments,
  });

  List<PastAppointment> pastAppointments;
  List<CommingAppointment> commingAppointments;

  factory MyAppointmentModel.fromJson(Map<String, dynamic> json) => MyAppointmentModel(
    pastAppointments: List<PastAppointment>.from(json["pastAppointments"].map((x) => PastAppointment.fromJson(x))),
    commingAppointments: List<CommingAppointment>.from(json["commingAppointments"].map((x) => CommingAppointment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pastAppointments": List<dynamic>.from(pastAppointments.map((x) => x)),
    "commingAppointments": List<dynamic>.from(commingAppointments.map((x) => x.toJson())),
  };
}

class CommingAppointment {
  CommingAppointment({
    required  this.id,
    required this.time,
    required  this.status,
    required  this.createdAt,
    required   this.updatedAt,
    this.deletedAt,
    required  this.patientId,
    required   this.doctorId,
    required    this.availableTimeId,
    required    this.date,
    required  this.doctor,
  });

  int id;
  String time;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int patientId;
  int doctorId;
  int availableTimeId;
  DateTime date;
  Doctor doctor;

  factory CommingAppointment.fromJson(Map<String, dynamic> json) => CommingAppointment(
    id: json["id"],
    time: json["time"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    patientId: json["patient_id"],
    doctorId: json["doctor_id"],
    availableTimeId: json["available_time_id"],
    date: DateTime.parse(json["date"]),
    doctor: Doctor.fromJson(json["doctor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time": time,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "patient_id": patientId,
    "doctor_id": doctorId,
    "available_time_id": availableTimeId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "doctor": doctor.toJson(),
  };
}
class PastAppointment {
  PastAppointment({
    required  this.id,
    required this.time,
    required  this.status,
    required  this.createdAt,
    required   this.updatedAt,
    this.deletedAt,
    required  this.patientId,
    required   this.doctorId,
    required    this.availableTimeId,
    required    this.date,
    required  this.doctor,
  });

  int id;
  String time;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int patientId;
  int doctorId;
  int availableTimeId;
  DateTime date;
  Doctor doctor;

  factory PastAppointment.fromJson(Map<String, dynamic> json) => PastAppointment(
    id: json["id"],
    time: json["time"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    patientId: json["patient_id"],
    doctorId: json["doctor_id"],
    availableTimeId: json["available_time_id"],
    date: DateTime.parse(json["date"]),
    doctor: Doctor.fromJson(json["doctor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time": time,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "patient_id": patientId,
    "doctor_id": doctorId,
    "available_time_id": availableTimeId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "doctor": doctor.toJson(),
  };
}

class Doctor {
  Doctor({
    required this.id,
    required   this.bio,
    required this.experience,
    required   this.contactNumber,
    required  this.qualification,
    required  this.fees,
    this.detailedAddress,
    this.about,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required  this.userId,
    required this.areaId,
    required this.user,
    required this.specifications,
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
  User user;
  List<Specification> specifications;

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
    user: User.fromJson(json["user"]),
    specifications: List<Specification>.from(json["specifications"].map((x) => Specification.fromJson(x))),
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
    "specifications": List<dynamic>.from(specifications.map((x) => x.toJson())),
  };
}

class Specification {
  Specification({
    required  this.id,
    required  this.name,
    required  this.createdAt,
    required  this.updatedAt,
    this.deletedAt,
    required  this.icon,
    required  this.pivot,
    required   this.media,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Icon icon;
  Pivot pivot;
  List<Icon> media;

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    icon: Icon.fromJson(json["icon"]),
    pivot: Pivot.fromJson(json["pivot"]),
    media: List<Icon>.from(json["media"].map((x) => Icon.fromJson(x))),
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

class Icon {
  Icon({
    required  this.id,
    required  this.modelType,
    required  this.modelId,
    required  this.uuid,
    required   this.collectionName,
    required    this.name,
    required   this.fileName,
    required    this.mimeType,
    required  this.disk,
    required  this.conversionsDisk,
    required   this.size,
    required  this.manipulations,
    required  this.customProperties,
    required  this.responsiveImages,
    required this.orderColumn,
    required  this.createdAt,
    required  this.updatedAt,
    required  this.url,
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

class Pivot {
  Pivot({
    required  this.singleDoctorId,
    required  this.specificationId,
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

class User {
  User({
    required  this.id,
    required  this.name,
    this.image,
    required  this.email,
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
