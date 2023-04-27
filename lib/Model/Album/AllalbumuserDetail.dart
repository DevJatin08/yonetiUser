// To parse this JSON data, do
//
//     final allalbumuser = allalbumuserFromJson(jsonString);

import 'dart:convert';

Allalbumuser allalbumuserFromJson(String str) =>
    Allalbumuser.fromJson(json.decode(str));

String allalbumuserToJson(Allalbumuser data) => json.encode(data.toJson());

class Allalbumuser {
  Allalbumuser({
    required this.albumName,
  });

  List<AlbumName> albumName;

  factory Allalbumuser.fromJson(Map<String, dynamic> json) => Allalbumuser(
        albumName: List<AlbumName>.from(
            json["album_name"].map((x) => AlbumName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "album_name": List<dynamic>.from(albumName.map((x) => x.toJson())),
      };
}

class AlbumName {
  AlbumName({
    required this.id,
    required this.name,
    required this.userId,
    required this.imgCnt,
  });

  String id;
  String name;
  String userId;
  String imgCnt;

  factory AlbumName.fromJson(Map<String, dynamic> json) => AlbumName(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        imgCnt: json["img_cnt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "img_cnt": imgCnt,
      };
}
