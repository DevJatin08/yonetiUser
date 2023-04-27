import 'package:userapp/Model/Order/ActiveOrder.dart';

class PastOrder {
  PastOrder({
    this.pastBooking,
  });

  List<Booking>? pastBooking;

  factory PastOrder.fromJson(Map<String, dynamic> json) => PastOrder(
        pastBooking: List<Booking>.from(
            json["past_booking"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "past_booking": List<dynamic>.from(pastBooking!.map((x) => x.toJson())),
      };
}
