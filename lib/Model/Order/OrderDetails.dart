// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) => OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  OrderDetails({
    required this.orderId,
    required this.marchantId,
    required this.date,
    required this.orderDate,
    required this.startTime,
    required this.endTime,
    required this.serviceCount,
    required this.userName,
    required this.userAddress,
    required this.userEmail,
    required this.userZipCode,
    required this.phoneNum,
    required this.orderStatus,
    required this.marchantRating,
    required this.userPic,
    required this.coverPhoto,
    required this.orderDetails,
  });

  String orderId;
  String marchantId;
  String date;
  String startTime;
  String endTime;
  String orderDate;
  int serviceCount;
  String userName;
  dynamic userAddress;
  String userEmail;
  dynamic userZipCode;
  String phoneNum;
  String orderStatus;
  double marchantRating;
  String userPic;
  String coverPhoto;
  List<OrderDetail> orderDetails;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        orderId: json["order_id"],
        marchantId: json["marchant_id"],
        date: json["date"],
        orderDate: json["order_date"],
        startTime: json["start_time"].toString(),
        endTime: json["end_time"].toString(),
        serviceCount: json["service_count"],
        userName: json["user_name"],
        userAddress: json["user_address"],
        userEmail: json["user_email"],
        userZipCode: json["user_zip_code"],
        phoneNum: json["phone_num"],
        orderStatus: json["order_status"],
        marchantRating: double.parse(json["marchant_rating"]),
        userPic: json["user_pic"],
        coverPhoto: json["cover_photo"],
        orderDetails: List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "marchant_id": marchantId,
        "date": date,
        "order_date": orderDate,
        "start_time": startTime,
        "end_time": endTime,
        "service_count": serviceCount,
        "user_name": userName,
        "user_address": userAddress,
        "user_email": userEmail,
        "user_zip_code": userZipCode,
        "phone_num": phoneNum,
        "order_status": orderStatus,
        "marchant_rating": marchantRating,
        "user_pic": userPic,
        "cover_photo": coverPhoto,
        "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    required this.serviceDetails,
    required this.servicePrice,
    required this.serviceTime,
  });

  String serviceDetails;
  String servicePrice;
  String serviceTime;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        serviceDetails: json["service_details"],
        servicePrice: json["service_price"],
        serviceTime: json["service_time"],
      );

  Map<String, dynamic> toJson() => {
        "service_details": serviceDetails,
        "service_price": servicePrice,
        "service_time": serviceTime,
      };
}
