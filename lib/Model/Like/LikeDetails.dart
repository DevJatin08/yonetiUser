// To parse this JSON data, do
//
//     final likeData = likeDataFromJson(jsonString);

import 'dart:convert';

LikeData likeDataFromJson(String str) => LikeData.fromJson(json.decode(str));

String likeDataToJson(LikeData data) => json.encode(data.toJson());

class LikeData {
  LikeData({
    this.imageCnt,
  });

  int? imageCnt;

  factory LikeData.fromJson(Map<String, dynamic> json) => LikeData(
        imageCnt: json["image_CNT"],
      );

  Map<String, dynamic> toJson() => {
        "image_CNT": imageCnt,
      };
}
