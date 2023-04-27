import 'package:flutter/widgets.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Home/HomeCategories.dart';
import 'package:userapp/Model/Home/HomeMerchantList.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class HomeService extends ChangeNotifier {
  HomeCategories homeCategoriesEmpty = HomeCategories(categories: []);
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

  Future getMerchantList() async {
    homeMerchantCategory.marchantDetails = [];
    final res = await apiCall.apiGetMarchantList(categoryId: categoryId);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
       homeMerchantCategory =
          HomeMerchantCategories.fromJson(res['result']);
    } else {
       homeMerchantCategory.marchantDetails;
    }
    notifyListeners();
  }
}
