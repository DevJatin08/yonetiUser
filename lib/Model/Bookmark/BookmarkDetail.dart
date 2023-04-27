// To parse this JSON data, do
//
//     final BookmarkData = BookmarkDataFromJson(jsonString);

import 'dart:convert';

BookmarkData BookmarkDataFromJson(String str) =>
    BookmarkData.fromJson(json.decode(str));

String BookmarkDataToJson(BookmarkData data) => json.encode(data.toJson());

class BookmarkData {
  BookmarkData({
    required this.MarchantDetails1,
  });

  List<MarchantDetail1> MarchantDetails1;

  factory BookmarkData.fromJson(Map<String, dynamic> json) => BookmarkData(
        MarchantDetails1: List<MarchantDetail1>.from(
            json["marchant_details"].map((x) => MarchantDetail1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marchant_details":
            List<dynamic>.from(MarchantDetails1.map((x) => x.toJson())),
      };
}

class MarchantDetail1 {
  MarchantDetail1({
    required this.id,
    required this.bookmarkId,
    required this.fullname,
    required this.phoneNum,
    required this.address,
    required this.rating,
    required this.businessStartTime,
    required this.businessCloseTime,
    required this.avatar,
    required this.businessDetails,
  });

  String id;
  String bookmarkId;
  String fullname;
  String phoneNum;
  String address;
  String rating;
  String businessStartTime;
  String businessCloseTime;
  String avatar;
  String businessDetails;

  factory MarchantDetail1.fromJson(Map<String, dynamic> json) =>
      MarchantDetail1(
        id: json["id"],
        bookmarkId: json["bookmark_id"],
        fullname: json["fullname"],
        phoneNum: json["phone_num"],
        address: json["address"],
        rating: json["rating"],
        businessStartTime: json["business_start_time"],
        businessCloseTime: json["business_close_time"],
        avatar: json["avatar"],
        businessDetails: json["business_details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookmark_id": bookmarkId,
        "fullname": fullname,
        "phone_num": phoneNum,
        "address": address,
        "rating": rating,
        "business_start_time": businessStartTime,
        "business_close_time": businessCloseTime,
        "avatar": avatar,
        "business_details": businessDetails,
      };
}
