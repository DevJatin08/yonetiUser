// To parse this JSON data, do
//
//     final imageData = imageDataFromJson(jsonString);

import 'dart:convert';

ImageData imageDataFromJson(String str) => ImageData.fromJson(json.decode(str));

String imageDataToJson(ImageData data) => json.encode(data.toJson());

class ImageData {
  ImageData({
    required this.images,
  });

  List<Image> images;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.id,
    required this.name,
    required this.userId,
    required this.albumId,
  });

  String id;
  String name;
  String userId;
  String albumId;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        albumId: json["album_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "album_id": albumId,
      };
}
