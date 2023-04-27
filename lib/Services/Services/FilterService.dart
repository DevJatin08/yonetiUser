import 'package:flutter/cupertino.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class FilterService extends ChangeNotifier {
  Future getFilter({
    required int opennow,
    required double lat,
    required double long,
    required int rateing,
    required int nearest,
    required int cost_low_to_high,
    required int cost_high_to_low,
    required int homeservice,
  }) async {
    final res = await apiCall.apiFilter(
        opennow: opennow,
        lat: lat,
        long: long,
        rateing: rateing,
        nearest: nearest,
        cost_low_to_high: cost_low_to_high,
        cost_high_to_low: cost_high_to_low,
        homeservice: homeservice);
    ResponseData responseData = ResponseData.fromJson(res);
  }

  notifyListeners();
}
