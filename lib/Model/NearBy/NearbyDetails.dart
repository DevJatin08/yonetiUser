// To parse this JSON data, do
//
//     final NearbyModel = NearbyModelFromJson(jsonString);

import 'dart:convert';

import 'package:userapp/Model/Home/HomeMerchantList.dart';

NearbyModel NearbyModelFromJson(String str) =>
    NearbyModel.fromJson(json.decode(str));

String NearbyModelToJson(NearbyModel data) => json.encode(data.toJson());

class NearbyModel {
  NearbyModel({
    this.discovery,
  });

  List<Discovery>? discovery;

  factory NearbyModel.fromJson(Map<String, dynamic> json) => NearbyModel(
        discovery: List<Discovery>.from(
            json["discovery"].map((x) => Discovery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "discovery": List<dynamic>.from(discovery!.map((x) => x.toJson())),
      };
}

class Discovery {
  Discovery({
    this.categoryId,
    this.categoryName,
    this.marchant,
  });

  String? categoryId;
  String? categoryName;
  List<Marchant>? marchant;

  factory Discovery.fromJson(Map<String, dynamic> json) => Discovery(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        marchant: List<Marchant>.from(
            json["marchant"].map((x) => Marchant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "marchant": List<dynamic>.from(marchant!.map((x) => x.toJson())),
      };
}

class Marchant {
  Marchant({
    this.id,
    this.name,
    this.address,
    this.image,
    this.category,
  });

  String? id;
  String? name;
  String? address;
  String? image;
  String? category;

  factory Marchant.fromJson(Map<String, dynamic> json) => Marchant(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "image": image,
        "category": category,
      };
}
