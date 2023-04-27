import 'dart:convert';

TopReviews topReviewsFromJson(String str) => TopReviews.fromJson(json.decode(str));

String topReviewsToJson(TopReviews data) => json.encode(data.toJson());

class TopReviews {
  TopReviews({
    this.reviews,
  });

  List<Review>? reviews;

  factory TopReviews.fromJson(Map<String, dynamic> json) => TopReviews(
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Review {
  Review({
    this.id,
    this.name,
    this.image,
    this.totalReviews,
    this.totalPhotos,
    this.isFollow,
    this.ratingCategory,
    this.rank,
  });

  String? id;
  String? name;
  String? image;
  String? totalReviews;
  String? totalPhotos;
  bool? isFollow;
  RatingCategory? ratingCategory;
  int? rank;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        totalReviews: json["total_reviews"],
        totalPhotos: json["total_photos"],
        isFollow: json["is_follow"],
        ratingCategory: ratingCategoryValues.map[json["rating_category"]],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "total_reviews": totalReviews,
        "total_photos": totalPhotos,
        "is_follow": isFollow,
        "rating_category": ratingCategoryValues.reverse[ratingCategory],
        "rank": rank,
      };
}

enum RatingCategory { GOLD, DIAMOND, SILVER }

extension RatingCategoryExtension on RatingCategory {
  String rating() {
    return this.toString().split(".")[1];
  }
}

final ratingCategoryValues = EnumValues({
  "Diamond": RatingCategory.DIAMOND,
  "Gold": RatingCategory.GOLD,
  "Silver": RatingCategory.SILVER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
