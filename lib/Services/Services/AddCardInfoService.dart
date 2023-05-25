import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Cardinfo/Cardinfo.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class AddCardINfoService extends ChangeNotifier {
  // Cardinfo _cardinfoEmpty = Cardinfo(
  //     userId: "", appType: "", cardNo: "", expired: "", cardHolderName: "", cvv: "", createdAt: "");
  Future addCardInfo(
      {required String card_no,
      required String expire,
      required String holder_name,
      required String cvv}) async {
    final res = await apiCall.apiAddCard(
        card_no: card_no, expire: expire, holder_name: holder_name, cvv: cvv);
    ResponseData responseData = ResponseData.fromJson(res);
    notifyListeners();
  }

  Future<List<CardinfoResult>> getCardinfo() async {
    Cardinfo data = Cardinfo();
    final res = await apiCall.apiGetCardInfo();
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      data = Cardinfo.fromJson(res);
      return data.result!;
    } else {
      return <CardinfoResult>[];
    }
  }
}
