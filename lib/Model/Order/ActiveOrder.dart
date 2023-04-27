// To parse this JSON data, do
//
//     final activeAndPastOrder = activeAndPastOrderFromJson(jsonString);

import 'dart:convert';

ActiveOrder activeAndPastOrderFromJson(String str) => ActiveOrder.fromJson(json.decode(str));

String activeAndPastOrderToJson(ActiveOrder data) => json.encode(data.toJson());

class ActiveOrder {
  ActiveOrder({
    this.orders,
  });

  List<Booking>? orders;

  factory ActiveOrder.fromJson(Map<String, dynamic> json) => ActiveOrder(
        orders: List<Booking>.from(json["active_booking"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "active_booking": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Booking {
  Booking({
    this.orderId,
    this.marchantId,
    this.date,
    this.bookingDate,
    this.startTime,
    this.endTime,
    this.amount,
    this.orderDetails,
  });

  String? orderId;
  String? marchantId;
  String? date;
  String? bookingDate;
  String? startTime;
  String? endTime;
  String? amount;
  String? orderDetails;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        orderId: json["order_id"],
        marchantId: json["marchant_id"],
        date: json["date"],
        bookingDate: json["booking_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        orderDetails: json["order_details"],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "marchant_id": marchantId,
        "date": date,
        "booking_date": bookingDate,
        "start_time": startTime,
        "end_time": endTime,
        "order_details": orderDetails,
        'amount': amount,
      };
}
