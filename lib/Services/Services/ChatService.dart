import 'dart:async';

import 'package:flutter/material.dart';
import 'package:userapp/Model/Chat/ChatModal.dart';
import 'package:userapp/Model/Chat/GetChat.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Homepage.dart';
import 'package:userapp/Services/api_client/APICall.dart';

class ChatService extends ChangeNotifier with timerMixin {
  String? customerId;
  APICall apiCall = APICall();
  List<GetChat>? chatList = [];
  List<ChatModal> chats = [];
  ChatModal? currentChat;

  setCustomerId(String id) async {
    customerId = id;

    cleanData();
  }

  setCurrentChat(ChatModal chatModal) {
    this.currentChat = chatModal;
    notifyListeners();
  }

  cleanData() {
    chatList = null;
    notifyListeners();
  }

  ChatService() {
    chatList = [];
    loadChatsList();
    startTimer(voidCallBack: loadChatsList);
  }

  Future loadChatsList() async {
    final res = await apiCall.getChatList();
    if (res == null) {
      return;
    }
    final ResponseData responseData = ResponseData.fromJson(res);
    // log("error", error: "errror");
    if (res["result"] is List) {
      chats = (res["result"] as List).map((e) => ChatModal.fromJson(e)).toList();
      // for (var v in res["result"] as List) {
      //   chats.add(ChatModal.fromJson(v));
      // }
    }
    notifyListeners();
  }

  Future Chat({
    required String chat_text,
  }) async {
    final res = await apiCall.apiChat(
        // userId: customerId.toString(),
        userId: customerId.toString(),
        chat_text: chat_text);
    ResponseData responseData = ResponseData.fromJson(res);

    if (responseData.statusCode == true) {
      await apiCall.sendNotification(
        title: userName,
        body: chat_text,
        to: res["device_id"],
      );
    }
    notifyListeners();
  }

  Future getChat() async {
    // print("anm,sdbkjsadakshdk =" + customerId.toString());
    final res = await apiCall.apiGetChat(userid: customerId.toString()
        // customerId.toString()
        );

    ResponseData responseData = ResponseData.fromJson(res);

    chatList = List<GetChat>.from(res['result'].map((e) => GetChat.fromJson(e))).reversed.toList();
    notifyListeners();
    // return  List<GetChat>.from['result'].map(e)=>GetChat.fromJson(e);
  }
}

mixin timerMixin {
  Timer? timer;

  startTimer({VoidCallback? voidCallBack}) {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (voidCallBack != null) voidCallBack();
    });
  }

  stop() {
    timer?.cancel();
    timer = null;
  }
}
