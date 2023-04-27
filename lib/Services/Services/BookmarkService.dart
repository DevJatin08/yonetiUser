import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Bookmark/BookmarkDetail.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Homepage.dart';

class BookmarkService extends ChangeNotifier {
  BookmarkData BookmarkDataEmpty = BookmarkData(MarchantDetails1: []);
  BookmarkData BookMarkData = BookmarkData(MarchantDetails1: []);

  Future<Map<String, dynamic>> getBookmarkCategories() async {
    final res = await apiCall.apiGetBookmark();

    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      BookMarkData = BookmarkData.fromJson(res['result']);
      return res;
    }
    return res;
  }

  Future addBookmark({required BuildContext context, required String business_id}) async {
    final res = await apiCall.apiAddBookmark(business_id: business_id);
    print(res);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode == true) {
      await apiCall.sendNotification(
        title: "Bookmark",
        body: "${userName} Bookmark Your Service",
        to: res['device_id'],
      );
    }
    // snackbar(responseData.message.toString(), context!);
  }

  Future deleteBookmark(
      {required BuildContext context, required int index, required String business_id}) async {
    final res = await apiCall.apiDeleteBookmark(business_id: business_id);
    BookmarkDataEmpty.MarchantDetails1.remove(index);
    ResponseData responseData = ResponseData.fromJson(res);
    // snackbar(responseData.message.toString(), context!);
    notifyListeners();
  }
}
