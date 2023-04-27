// To parse this JSON data, do
//
//     final chatModal = chatModalFromJson(jsonString);

import 'dart:convert';

ChatModal chatModalFromJson(String str) => ChatModal.fromJson(json.decode(str));

String chatModalToJson(ChatModal data) => json.encode(data.toJson());

class ChatModal {
  ChatModal({
    required this.userId,
    required this.marchantId,
    this.chatText,
    this.chatDatetime,
    required this.appType,
    this.userFullname,
    this.cntUnread,
    this.userImage,
  });

  String userId;
  String marchantId;
  String? chatText;
  DateTime? chatDatetime;
  String appType;
  String? userFullname;
  String? cntUnread;
  String? userImage;
  String get fullName {
    return this.userFullname ?? "";
  }

  String get lastMsg {
    return this.chatText ?? "";
  }

  String get lastDate {
    if (chatDatetime == null) {
      return "";
    }
    return (chatDatetime!.hour % 12).toString() +
        ":" +
        chatDatetime!.minute.toString().padLeft(2, "0") +
        " ${chatDatetime!.hour >= 12 ? "pm" : "am"}";
  }

  int get unreadCount {
    return int.parse(this.cntUnread ?? 0.toString());
  }

  factory ChatModal.fromJson(Map<String, dynamic> json) => ChatModal(
        userId: json["user_id"],
        marchantId: json["marchant_id"],
        chatText: json["chat_text"],
        chatDatetime: DateTime.parse(json["chat_datetime"]),
        appType: json["app_type"],
        userFullname: json["user_fullname"],
        cntUnread: json["CNT_unread"],
        userImage: json["user_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "marchant_id": marchantId,
        "chat_text": chatText,
        "chat_datetime": chatDatetime?.toIso8601String(),
        "app_type": appType,
        "user_fullname": userFullname,
        "CNT_unread": cntUnread,
        "user_image": userImage,
      };
}
