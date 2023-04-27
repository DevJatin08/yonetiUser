// To parse this JSON data, do
//
//     final getCommentData = getCommentDataFromJson(jsonString);

import 'dart:convert';

GetCommentData getCommentDataFromJson(String str) =>
    GetCommentData.fromJson(json.decode(str));

String getCommentDataToJson(GetCommentData data) => json.encode(data.toJson());

class GetCommentData {
  GetCommentData({
    required this.comments,
  });

  List<Comment> comments;

  factory GetCommentData.fromJson(Map<String, dynamic> json) => GetCommentData(
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.comments,
    required this.commentsDate,
  });

  String userId;
  String userName;
  String avatar;
  String comments;
  DateTime commentsDate;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["user_id"],
        userName: json["user_name"],
        avatar: json["avatar"],
        comments: json["comments"],
        commentsDate: DateTime.parse(json["comments_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "avatar": avatar,
        "comments": comments,
        "comments_date": commentsDate.toIso8601String(),
      };
}
