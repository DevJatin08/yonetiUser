// To parse this JSON data, do
//
//     final commentData = commentDataFromJson(jsonString);

import 'dart:convert';

CommentData commentDataFromJson(String str) =>
    CommentData.fromJson(json.decode(str));

String commentDataToJson(CommentData data) => json.encode(data.toJson());

class CommentData {
  CommentData({
    required this.commentsCnt,
  });

  int commentsCnt;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        commentsCnt: json["comments_CNT"],
      );

  Map<String, dynamic> toJson() => {
        "comments_CNT": commentsCnt,
      };
}
