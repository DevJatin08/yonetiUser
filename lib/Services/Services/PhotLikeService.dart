import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Like/likeDetail.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class GetLikeDataService extends ChangeNotifier {
  GetLikeData GetLikeDataEmpty = GetLikeData(likeUsers: [], flag: '');

  Future<GetLikeData> getLikeData({required String ImageID}) async {
    final res = await apiCall.apiGetPhotoLikeDetails(ImageID: ImageID);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return GetLikeData.fromJson(res['result']);
    } else {
      return GetLikeDataEmpty;
    }
  }

  notifyListeners();
}
