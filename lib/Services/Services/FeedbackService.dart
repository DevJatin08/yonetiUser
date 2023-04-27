import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class FeedBackService extends ChangeNotifier {
  Future getFeedback({required String feedback}) async {
    final res = await apiCall.apiFeedback(feedback: feedback);
    ResponseData responseData = ResponseData.fromJson(res);
    notifyListeners();
  }
}
