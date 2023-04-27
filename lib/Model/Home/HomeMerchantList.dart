// To parse this JSON data, do
//
//     final homeMerchantCategories = homeMerchantCategoriesFromJson(jsonString);

import 'dart:convert';

HomeMerchantCategories homeMerchantCategoriesFromJson(String str) =>
    HomeMerchantCategories.fromJson(json.decode(str));

String homeMerchantCategoriesToJson(HomeMerchantCategories data) =>
    json.encode(data.toJson());

class HomeMerchantCategories {
  HomeMerchantCategories({
    this.marchantDetails,
  });

  List<MarchantDetail>? marchantDetails;

  factory HomeMerchantCategories.fromJson(Map<String, dynamic> json) =>
      HomeMerchantCategories(
        marchantDetails: List<MarchantDetail>.from(
            json["marchant_details"].map((x) => MarchantDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marchant_details":
            List<dynamic>.from(marchantDetails!.map((x) => x.toJson())),
      };
}

class MarchantDetail {
  MarchantDetail({
    this.id,
    this.fullname,
    this.phoneNum,
    this.address,
    this.rating,
    this.businessStartTime,
    this.businessCloseTime,
    this.avatar,
    this.businessDetails,
    this.isBookmark,
  });

  String? id;
  String? fullname;
  String? phoneNum;
  String? address;
  String? rating;
  String? businessStartTime;
  String? businessCloseTime;
  String? avatar;
  String? businessDetails;
  bool? isBookmark;

  factory MarchantDetail.fromJson(Map<String, dynamic> json) => MarchantDetail(
        id: json["id"].toString(),
        fullname: json["fullname"].toString(),
        phoneNum: json["phone_num"].toString(),
        address: json["address"].toString(),
        rating: json["rating"].toString(),
        businessStartTime: json["business_start_time"].toString(),
        businessCloseTime: json["business_close_time"].toString(),
        avatar: json["avatar"].toString(),
        businessDetails: json["business_details"].toString(),
        isBookmark: json["is_bookmark"] != null ? json["is_bookmark"] : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone_num": phoneNum,
        "address": address,
        "rating": rating,
        "business_start_time": businessStartTime,
        "business_close_time": businessCloseTime,
        "avatar": avatar,
        "business_details": businessDetails,
        "is_bookmark": isBookmark,
      };
}
