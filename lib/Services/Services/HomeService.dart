import 'package:flutter/widgets.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Home/HomeAdsPackage.dart';
import 'package:userapp/Model/Home/HomeCategories.dart';
import 'package:userapp/Model/Home/HomeMerchantList.dart';
import 'package:userapp/Model/Home/payment_history_model.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Screen/CommonWidgets/Snackbar.dart';

class HomeService extends ChangeNotifier {
  HomeCategories homeCategoriesEmpty = HomeCategories(categories: []);
  PaymentHistoryModel paymentHistory = PaymentHistoryModel();
  HomePackagesDetail packagesDetailsList =
      HomePackagesDetail(packagesDetails: []);
  HomeMerchantCategories homeMerchantCategory =
      HomeMerchantCategories(marchantDetails: []);
  String categoryName = '';
  String categoryId = '';
  setCategoryData(String cat_id, String cat_name) {
    categoryName = cat_name;
    categoryId = cat_id;
    notifyListeners();
  }

  Future<HomeCategories> getCategories() async {
    final res = await apiCall.apiHomeCategories();
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return HomeCategories.fromJson(res['result']);
    } else {
      return homeCategoriesEmpty;
    }
  }

  Future<PaymentHistoryModel> getPaymentHistory({
    required String startData,
    required String lastDate,
  }) async {
    final res = await apiCall.apiPaymentHistory(
        startData: startData, lastDate: lastDate);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return PaymentHistoryModel.fromJson(res);
    } else {
      return paymentHistory;
    }
  }

  Future getMerchantList() async {
    homeMerchantCategory.marchantDetails = [];
    final res = await apiCall.apiGetMarchantList(categoryId: categoryId);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode! &&
        (res['result'] as Map).containsKey('marchant_details')) {
      homeMerchantCategory = HomeMerchantCategories.fromJson(res['result']);
    } else {
      homeMerchantCategory.marchantDetails;
    }
    notifyListeners();
  }

  Future<HomePackagesDetail> getAdsPackages() async {
    final res = await apiCall.apiGetAdsPackagesList();
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode! &&
        (res['result'] as Map).containsKey('packages')) {
      return packagesDetailsList = HomePackagesDetail.fromJson(res['result']);
    } else {
      return packagesDetailsList;
    }
  }

  Future<ResponseData> adsPackageRequests(
      {required String packageId,
      required String packageName,
      required BuildContext context}) async {
    final res = await apiCall.adsPackageRequests(
        packageId: packageId, packageName: packageName);
    snackbar(res['message'], context);
    return ResponseData.fromJson(res);
  }
}
