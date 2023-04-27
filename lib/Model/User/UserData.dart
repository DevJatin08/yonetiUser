// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.sessionId,
    this.userId,
    this.email,
    this.fullname,
    this.phoneNum,
    this.userType,
    this.businessType,
    this.avatar,
    this.coverPhoto,
    this.website,
    this.userBio,
    this.gender,
    this.address,
    this.dob,
    this.createdAt,
    this.deviceId,
    this.deviceType,
    this.isPushNotification,
    this.isProfileCompleted,
  });

  String? sessionId;
  String? userId;
  String? email;
  String? fullname;
  String? phoneNum;
  String? userType;
  String? businessType;
  String? avatar;
  String? coverPhoto;
  String? website;
  String? userBio;
  String? gender;
  Address? address;
  String? dob;
  String? createdAt;
  String? deviceId;
  String? deviceType;
  String? isPushNotification;
  String? isProfileCompleted;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        sessionId: json["session_id"],
        userId: json["user_id"],
        email: json["email"],
        fullname: json["fullname"],
        phoneNum: json["phone_num"],
        userType: json["user_type"],
        businessType: json["business_type"],
        avatar: json["avatar"],
        coverPhoto: json["cover_photo"],
        website: json["website"],
        userBio: json["user_bio"],
        gender: json["gender"],
        address: Address.fromJson(json["address"]),
        dob: json["dob"],
        createdAt: json["created_at"],
        deviceId: json["device_id"],
        deviceType: json["device_type"],
        isPushNotification: json["is_push_notification"],
        isProfileCompleted: json["is_profile_completed"],
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "user_id": userId,
        "email": email,
        "fullname": fullname,
        "phone_num": phoneNum,
        "user_type": userType,
        "business_type": businessType,
        "avatar": avatar,
        "cover_photo": coverPhoto,
        "website": website,
        "user_bio": userBio,
        "gender": gender,
        "address": address!.toJson(),
        "dob": dob.toString(),
        "created_at": createdAt,
        "device_id": deviceId,
        "device_type": deviceType,
        "is_push_notification": isPushNotification,
        "is_profile_completed": isProfileCompleted,
      };
}

class Address {
  Address({
    this.country,
    this.city,
    this.street,
    this.zipCode,
  });

  String? country;
  String? city;
  String? street;
  String? zipCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"] ?? "",
        city: json["city"] ?? "",
        street: json["street"] ?? "",
        zipCode: json["zip_code"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
        "street": street,
        "zip_code": zipCode,
      };
}
