import 'package:flutter/cupertino.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Model/TopPhotos/TopPhotosDetail.dart';

class TopPhotosService extends ChangeNotifier {
  TopPhotosData TopPhotosDataEmpty = TopPhotosData(photos: []);

  Future<TopPhotosData> getTopPhotos({double? lat, double? long}) async {
    final res = await apiCall.apiTopPhotos();

    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return TopPhotosData.fromJson(res['result']);
    } else {
      return TopPhotosDataEmpty;
    }
  }
}
