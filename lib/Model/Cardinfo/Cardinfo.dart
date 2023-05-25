// // To parse this JSON data, do
// //
// //     final cardinfo = cardinfoFromJson(jsonString);

// import 'dart:convert';

// Cardinfo cardinfoFromJson(String str) => Cardinfo.fromJson(json.decode(str));

// String cardinfoToJson(Cardinfo data) => json.encode(data.toJson());

// class Cardinfo {
//   Cardinfo({
//     required this.userId,
//     required this.appType,
//     required this.cardNo,
//     required this.expired,
//     required this.cardHolderName,
//     required this.cvv,
//     required this.createdAt,
//   });

//   String userId;
//   String appType;
//   String cardNo;
//   String expired;
//   String cardHolderName;
//   String cvv;
//   String createdAt;

//   factory Cardinfo.fromJson(Map<String, dynamic> json) => Cardinfo(
//         userId: json["user_id"],
//         appType: json["app_type"],
//         cardNo: json["card_no"],
//         expired: json["expired"],
//         cardHolderName: json["card_holder_name"],
//         cvv: json["cvv"],
//         createdAt: json["created_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "app_type": appType,
//         "card_no": cardNo,
//         "expired": expired,
//         "card_holder_name": cardHolderName,
//         "cvv": cvv,
//         "created_at": createdAt,
//       };
// }

class Cardinfo {
  bool? statusCode;
  String? message;
  List<CardinfoResult>? result;

  Cardinfo({this.statusCode, this.message, this.result});

  Cardinfo.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <CardinfoResult>[];
      json['result'].forEach((v) {
        result!.add(new CardinfoResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardinfoResult {
  String? userId;
  String? appType;
  String? cardNo;
  String? expired;
  String? cardHolderName;
  String? cvv;
  String? createdAt;

  CardinfoResult(
      {this.userId,
      this.appType,
      this.cardNo,
      this.expired,
      this.cardHolderName,
      this.cvv,
      this.createdAt});

  CardinfoResult.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    appType = json['app_type'];
    cardNo = json['card_no'];
    expired = json['expired'];
    cardHolderName = json['card_holder_name'];
    cvv = json['cvv'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['app_type'] = this.appType;
    data['card_no'] = this.cardNo;
    data['expired'] = this.expired;
    data['card_holder_name'] = this.cardHolderName;
    data['cvv'] = this.cvv;
    data['created_at'] = this.createdAt;
    return data;
  }
}
