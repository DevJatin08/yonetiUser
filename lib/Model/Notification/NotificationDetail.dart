// To parse this JSON data, do
//
//     final notificationModal = notificationModalFromJson(jsonString);

import 'dart:convert';

import 'package:userapp/Constant/timeDiffrence.dart';

NotificationModal notificationModalFromJson(String str) =>
    NotificationModal.fromJson(json.decode(str));

String notificationModalToJson(NotificationModal data) => json.encode(data.toJson());

class NotificationModal {
  NotificationModal({
    this.notification,
  });

  List<Notification>? notification;

  factory NotificationModal.fromJson(Map<String, dynamic> json) => NotificationModal(
        notification:
            List<Notification>.from(json["notification"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notification": List<dynamic>.from(notification!.map((x) => x.toJson())),
      };
}

class Notification {
  Notification({
    this.notificationId,
    this.userId,
    this.text,
    this.notificationType,
    this.refId,
    this.date,
    this.isRead,
    this.senderAvatar,
  });

  String? notificationId;
  String? userId;
  String? text;
  String? notificationType;
  String? refId;
  String? date;
  String? isRead;
  String? senderAvatar;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        notificationId: json["notification_id"],
        userId: json["user_id"],
        text: json["text"],
        notificationType: json["notification_type"],
        refId: json["ref_id"],
        date: dateDifference(json["date"]),
        isRead: json['is_read'],
        senderAvatar: json['sender_avatar'],
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "user_id": userId,
        "text": text,
        "notification_type": notificationType,
        "ref_id": refId,
        "date": date,
        "is_read": isRead,
        "sender_avatar": senderAvatar,
      };
}

class Result {
  Result({
    this.count,
    this.notification,
  });

  int? count;
  bool? notification;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        count: json["count"] == null ? null : json["count"],
        notification: json["notification"] == null ? null : json["notification"],
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "notification": notification == null ? null : notification,
      };
}
