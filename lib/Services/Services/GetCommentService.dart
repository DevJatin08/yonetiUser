import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Comment/GetCommentDetail.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class GetCommentService extends ChangeNotifier {
  GetCommentData getCommentModalEmpty = GetCommentData(comments: []);

  Future<GetCommentData> getCommentData({required String ImageID}) async {
    final res = await apiCall.apiGetComments(ImageID: ImageID);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return GetCommentData.fromJson(res['result']);
    } else {
      return getCommentModalEmpty;
    }
  }

  notifyListeners();
}
