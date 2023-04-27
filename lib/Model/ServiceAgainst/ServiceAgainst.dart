// To parse this JSON data, do
//
//     final serviceAgainstdata = serviceAgainstdataFromJson(jsonString);

import 'dart:convert';

ServiceAgainstdata serviceAgainstdataFromJson(String str) =>
    ServiceAgainstdata.fromJson(json.decode(str));

String serviceAgainstdataToJson(ServiceAgainstdata data) =>
    json.encode(data.toJson());

class ServiceAgainstdata {
  ServiceAgainstdata({
    required this.MarchantServiceDatas,
  });

  List<MarchantServiceData> MarchantServiceDatas;
  

  factory ServiceAgainstdata.fromJson(Map<String, dynamic> json) =>
      ServiceAgainstdata(
        MarchantServiceDatas: List<MarchantServiceData>.from(
            json["marchant_services"]
                .map((x) => MarchantServiceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marchant_services":
            List<dynamic>.from(MarchantServiceDatas.map((x) => x.toJson())),
      };
}

class MarchantServiceData {
  MarchantServiceData({
    required this.id,
    required this.userId,
    required this.serviceid,
    required this.serviceTitle,
    required this.serviceCharged,
    required this.estimatedTime,
    required this.categoryId,
  });

  String id;
  String userId;
  String serviceid;
  String serviceTitle;
  String serviceCharged;
  String estimatedTime;
  String categoryId;

  factory MarchantServiceData.fromJson(Map<String, dynamic> json) =>
      MarchantServiceData(
        id: json["id"],
        userId: json["user_id"],
        serviceid: json["service_id"],
        serviceTitle: json["service_title"],
        serviceCharged: json["service_charged"],
        estimatedTime: json["estimated_time"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "service_title": serviceTitle,
        "service_charged": serviceCharged,
        "estimated_time": estimatedTime,
        "category_id": categoryId,
        "service_id": serviceid,
      };
}
