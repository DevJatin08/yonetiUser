// To parse this JSON data, do
//
//     final getLikeData = getLikeDataFromJson(jsonString);

import 'dart:convert';

GetLikeData getLikeDataFromJson(String str) =>
    GetLikeData.fromJson(json.decode(str));

String getLikeDataToJson(GetLikeData data) => json.encode(data.toJson());

class GetLikeData {
  GetLikeData({
    required this.likeUsers,
  });

  List<LikeUser> likeUsers;

  factory GetLikeData.fromJson(Map<String, dynamic> json) => GetLikeData(
        likeUsers: List<LikeUser>.from(
            json["like_users"].map((x) => LikeUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "like_users": List<dynamic>.from(likeUsers.map((x) => x.toJson())),
      };
}

class LikeUser {
  LikeUser({
    required this.userId,
    required this.userName,
    required this.avatar,
  });

  String userId;
  String userName;
  String avatar;

  factory LikeUser.fromJson(Map<String, dynamic> json) => LikeUser(
        userId: json["user_id"],
        userName: json["user_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "avatar": avatar,
      };
}
