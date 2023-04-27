import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Notification/NotificationDetail.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class NotificationService extends ChangeNotifier {
  String meassge = "";
  NotificationModal notificationmodalEmpty = NotificationModal(notification: []);
  Result result = Result();

  Future<NotificationModal> getCategories(int type) async {
    final res = await apiCall.apiNotifications(type);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return NotificationModal.fromJson(res['result']);
    } else {
      return notificationmodalEmpty;
    }
  }

  Future readNotification(String notificationId) async {
    final res = await apiCall.apiUpdateNotification(notificationId: notificationId);

    ResponseData responseData = ResponseData.fromJson(res);
    notifyListeners();
  }

  Future getCounter() async {
    final res = await apiCall.apiCounterNotification();

    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      result = Result.fromJson(res['result']);
    }
    notifyListeners();
  }

  Future sendNotification({required String deviceId}) async {
    final res = await apiCall.apiSendTestPushNotification(deviceId: deviceId);

    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      meassge = responseData.message.toString();
    }
    notifyListeners();
  }
}
