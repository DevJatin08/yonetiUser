import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/BookingService/BookingServiceDetail.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class BookdetailService extends ChangeNotifier {
  BookdetailServiceData GetBookdetailsEmpty = BookdetailServiceData(services: []);

  Future<BookdetailServiceData> getBookingData() async {
    final res = await apiCall.apibookingservice();
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return BookdetailServiceData.fromJson(res['result']);
    } else {
      return GetBookdetailsEmpty;
    }
  }

  notifyListeners();
}
