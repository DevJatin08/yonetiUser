import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/NearBy/NearbyDetails.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class NearbyService extends ChangeNotifier {
  NearbyModel nearbymodelEmpty = NearbyModel(discovery: []);

  Future<NearbyModel> getCategories({double? lat, double? long}) async {
    final res = await apiCall.apiUserDiscovery(lat: lat, long: long);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return NearbyModel.fromJson(res['result']);
    } else {
      return nearbymodelEmpty;
    }
  }
}
