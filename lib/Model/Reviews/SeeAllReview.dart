// To parse this JSON data, do
//
//     final reviewData = reviewDataFromJson(jsonString);

import 'dart:convert';

ReviewData reviewDataFromJson(String str) => ReviewData.fromJson(json.decode(str));

String reviewDataToJson(ReviewData data) => json.encode(data.toJson());

class ReviewData {
  ReviewData({
    required this.allReviews,
  });

  List<AllReview> allReviews;

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        allReviews: List<AllReview>.from(json["all_reviews"].map((x) => AllReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_reviews": List<dynamic>.from(allReviews.map((x) => x.toJson())),
      };
}

class AllReview {
  AllReview({
    required this.reviewId,
    required this.userId,
    required this.marchantId,
    required this.avatar,
    required this.date,
    required this.reviewedBy,
    required this.comments,
  });

  String reviewId;
  String userId;
  String marchantId;
  String avatar;
  String date;
  String reviewedBy;
  String comments;

  factory AllReview.fromJson(Map<String, dynamic> json) => AllReview(
        reviewId: json["review_id"],
        userId: json["user_id"],
        marchantId: json["marchant_id"],
        avatar: json["avatar"],
        date: json["date"],
        reviewedBy: json["reviewed_by"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "user_id": userId,
        "marchant_id": marchantId,
        "avatar": avatar,
        "date": date,
        "reviewed_by": reviewedBy,
        "comments": comments,
      };
}
