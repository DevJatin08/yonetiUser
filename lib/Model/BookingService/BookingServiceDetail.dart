// To parse this JSON data, do
//
//     final BookdetailServiceData = BookdetailServiceDataFromJson(jsonString);

import 'dart:convert';

BookdetailServiceData BookdetailServiceDataFromJson(String str) =>
    BookdetailServiceData.fromJson(json.decode(str));

String BookdetailServiceDataToJson(BookdetailServiceData data) =>
    json.encode(data.toJson());

class BookdetailServiceData {
  BookdetailServiceData({
    required this.services,
  });

  List<Service> services;

  factory BookdetailServiceData.fromJson(Map<String, dynamic> json) =>
      BookdetailServiceData(
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
