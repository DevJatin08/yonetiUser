// To parse this JSON data, do
//
//     final reserve = reserveFromJson(jsonString);

import 'dart:convert';

Reserve reserveFromJson(String str) => Reserve.fromJson(json.decode(str));

String reserveToJson(Reserve data) => json.encode(data.toJson());

class Reserve {
  Reserve({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  bool statusCode;
  String message;
  Result? result;

  factory Reserve.fromJson(Map<String, dynamic> json) => Reserve(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "result": result == null ? null : result!.toJson(),
      };
}

class Result {
  Result({
    this.marchantDetails,
    this.services,
    this.time,
  });

  List<ReserveMarchantDetail>? marchantDetails;
  List<ReserveService>? services;
  List<Time>? time;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        marchantDetails: json["marchant_details"] == null
            ? null
            : List<ReserveMarchantDetail>.from(
                json["marchant_details"].map((x) => ReserveMarchantDetail.fromJson(x))),
        services: json["services"] == null
            ? null
            : List<ReserveService>.from(json["services"].map((x) => ReserveService.fromJson(x))),
        time: json["time"] == null
            ? null
            : List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marchant_details": marchantDetails == null
            ? null
            : List<dynamic>.from(marchantDetails!.map((x) => x.toJson())),
        "services": services == null ? null : List<dynamic>.from(services!.map((x) => x.toJson())),
        "time": time == null ? null : List<dynamic>.from(time!.map((x) => x.toJson())),
      };
}

class ReserveMarchantDetail {
  ReserveMarchantDetail({
    required this.id,
    required this.brandName,
    required this.avatar,
    required this.coverPhoto,
    required this.rating,
    required this.businessType,
  });

  String id;
  String brandName;
  String avatar;
  String coverPhoto;
  String rating;
  String businessType;

  factory ReserveMarchantDetail.fromJson(Map<String, dynamic> json) => ReserveMarchantDetail(
        id: json["id"] == null ? null : json["id"],
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        coverPhoto: json["cover_photo"] == null ? null : json["cover_photo"],
        rating: json["rating"] == null ? null : json["rating"],
        businessType: json["business_type"] == null ? null : json["business_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "brand_name": brandName == null ? null : brandName,
        "avatar": avatar == null ? null : avatar,
        "cover_photo": coverPhoto == null ? null : coverPhoto,
        "rating": rating == null ? null : rating,
        "business_type": businessType == null ? null : businessType,
      };
}

class ReserveService {
  ReserveService({
    required this.serviceId,
    required this.name,
    required this.serviceCharges,
    required this.estimatedTime,
  });

  String serviceId;
  String name;
  String serviceCharges;
  String estimatedTime;

  factory ReserveService.fromJson(Map<String, dynamic> json) => ReserveService(
        serviceId: json["service_id"] == null ? null : json["service_id"],
        name: json["name"] == null ? null : json["name"],
        serviceCharges: json["service_charges"] == null ? null : json["service_charges"],
        estimatedTime: json["estimated_time"] == null ? null : json["estimated_time"],
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId == null ? null : serviceId,
        "name": name == null ? null : name,
        "service_charges": serviceCharges == null ? null : serviceCharges,
        "estimated_time": estimatedTime == null ? null : estimatedTime,
      };
}

class Time {
  Time({
    required this.orderTime,
  });

  String orderTime;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        orderTime: json["order_time"] == null ? null : json["order_time"],
      );

  Map<String, dynamic> toJson() => {
        "order_time": orderTime == null ? null : orderTime,
      };
}
