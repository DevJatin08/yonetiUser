// To parse this JSON data, do
//
//     final cardinfo = cardinfoFromJson(jsonString);

import 'dart:convert';

Cardinfo cardinfoFromJson(String str) => Cardinfo.fromJson(json.decode(str));

String cardinfoToJson(Cardinfo data) => json.encode(data.toJson());

class Cardinfo {
  Cardinfo({
    required this.userId,
    required this.appType,
    required this.cardNo,
    required this.expired,
    required this.cardHolderName,
    required this.cvv,
    required this.createdAt,
  });

  String userId;
  String appType;
  String cardNo;
  String expired;
  String cardHolderName;
  String cvv;
  String createdAt;

  factory Cardinfo.fromJson(Map<String, dynamic> json) => Cardinfo(
        userId: json["user_id"],
        appType: json["app_type"],
        cardNo: json["card_no"],
        expired: json["expired"],
        cardHolderName: json["card_holder_name"],
        cvv: json["cvv"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "app_type": appType,
        "card_no": cardNo,
        "expired": expired,
        "card_holder_name": cardHolderName,
        "cvv": cvv,
        "created_at": createdAt,
      };
}
