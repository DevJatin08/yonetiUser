// To parse this JSON data, do
//
//     final getChat = getChatFromJson(jsonString);

import 'dart:convert';

import 'package:userapp/Screen/NavigationScreens/Home/Chat/Chat.dart';

GetChat getChatFromJson(String str) => GetChat.fromJson(json.decode(str));

String getChatToJson(GetChat data) => json.encode(data.toJson());

class GetChat {
  GetChat({
    required this.chatId,
    required this.userId,
    required this.marchantId,
    required this.chatText,
    required this.chatDatetime,
    required this.appType,
  });

  String chatId;
  String userId;
  String marchantId;
  String chatText;
  DateTime chatDatetime;
  String appType;

  String get messageTime {
    return "${day[chatDatetime.weekday]}, ${month[chatDatetime.month - 1]} ${chatDatetime.day} ${chatDatetime.hour}:${chatDatetime.minute} ${(chatDatetime.hour < 12) ? "AM" : "PM"}";
  }

  factory GetChat.fromJson(Map<String, dynamic> json) => GetChat(
        chatId: json["chat_id"],
        userId: json["user_id"],
        marchantId: json["marchant_id"],
        chatText: json["chat_text"],
        chatDatetime: DateTime.parse(json["chat_datetime"]),
        appType: json["app_type"],
      );

  Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "user_id": userId,
        "marchant_id": marchantId,
        "chat_text": chatText,
        "chat_datetime": chatDatetime.toIso8601String(),
        "app_type": appType,
      };
}
