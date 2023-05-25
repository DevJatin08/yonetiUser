import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Album/Allalbum.dart';
import 'package:userapp/Model/Album/AllalbumuserDetail.dart';
import 'package:userapp/Model/Album/GetImages.dart';
import 'package:userapp/Model/BookingService/reserve.dart';
import 'package:userapp/Model/Comment/CommentDetail.dart';
import 'package:userapp/Model/Like/LikeDetails.dart';
import 'package:userapp/Model/Marchant/MarchantDetail.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Model/Reviews/SeeAllReview.dart';
import 'package:userapp/Model/ServiceAgainst/ServiceAgainst.dart';
import 'package:userapp/Screen/NavigationScreens/Home/Homepage.dart';

class MarchantService extends ChangeNotifier {
  String marchantId = '';

  String rating = "0.0";
  MarchantDetail marchantDetails = MarchantDetail();
  Allalbumuser AllalbumuserEmpty = Allalbumuser(albumName: []);
  AllalbumData AllalbumDataEmpty = AllalbumData(images: []);
  ImageData ImageDataEmpty = ImageData(images: []);
  ReviewData ReviewDataEmpty = ReviewData(allReviews: []);
  ReviewData ReviewDatas = ReviewData(allReviews: []);
  Result reserveServ = Result(services: []);

  // List<ReserveService> reserveService = [];
  ServiceAgainstdata marchantService =
      ServiceAgainstdata(MarchantServiceDatas: []);

  setMarchantId(String ma_rchantId, String ratings) {
    marchantId = ma_rchantId;
    this.rating = ratings;

    notifyListeners();
  }

  Future<MarchantDetail> marchantDetail() async {
    final res = await apiCall.apiGetMarchantAllDetails(marchantId: marchantId);
    print('marchant id = ${marchantId}');
    notifyListeners();
    return MarchantDetail.fromJson(res['result']['marchant_details'][0]);
  }

  Future<MarchantDetail> getMarchantDetail(Marchantid) async {
    final res = await apiCall.apiGetMarchantAllDetails(marchantId: Marchantid);
    print('marchant id = ${Marchantid}');
    // notifyListeners();
    marchantDetails =
        MarchantDetail.fromJson(res['result']['marchant_details'][0]);
    return marchantDetails;
  }

  Future<Allalbumuser> getCategories() async {
    final res = await apiCall.apiGetAlbumByUser(merchatId: marchantId);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return Allalbumuser.fromJson(res['result']);
    } else {
      return AllalbumuserEmpty;
    }
  }

  Future<AllalbumData> getCategories1() async {
    final res = await apiCall.apiGetImagesAgainstUser(merchatId: marchantId);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return AllalbumData.fromJson(res['result']);
    } else {
      return AllalbumDataEmpty;
    }
  }

  Future<ImageData> getimageCategories({required String albumId}) async {
    final res = await apiCall.apiGetImages(albumId: albumId);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return ImageData.fromJson(res['result']);
    } else {
      return ImageDataEmpty;
    }
  }

  Future addCommentData({
    required String comments,
    required String image_id,
    String? merchantId,
    String? imageUrl,
  }) async {
    final res = await apiCall.apiAddCommentPhoto(
        comments: comments, image_id: image_id, marchant_id: merchantId!);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      await apiCall.sendNotification(
        title: "Comment",
        body: "${userName?.trim()} Comment On Your Photo : $comments",
        to: res["result"]["device_id"],
        image: imageUrl,
      );
      return CommentData.fromJson(res['result']);
    }
    notifyListeners();
  }

  Future getServiceAgainst() async {
    final res = await apiCall.apiServiceAgainstCategory(marchantId: marchantId);
    marchantService = ServiceAgainstdata(MarchantServiceDatas: []);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      marchantService = ServiceAgainstdata.fromJson(res['result']);
    }
    notifyListeners();
  }

  Future getReserve() async {
    final res = await apiCall.reservation(marchantId: marchantId);
    reserveServ = Result(services: []);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return reserveServ = Result.fromJson(res['result']);
      notifyListeners();
      // return reserveServ;
    } else {
      // return reserveServ;
    }

    // return ReserveService.fromJson(res['result']['services']);
  }

  Future<ReviewData> GetAllReviwe() async {
    log(marchantId, name: "Review Merchant ID");
    final res = await apiCall.apiAllReviews(marchant_id: marchantId);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      ReviewDatas = ReviewData.fromJson(res['result']);
      notifyListeners();
      return ReviewDatas;
    } else {
      return ReviewDataEmpty;
    }
  }

  LikeData likeDataEmpty = LikeData(imageCnt: 0);

  Future<LikeData> addLike(
      {required String image_id, String? merchantId, String? imageUrl}) async {
    final res =
        await apiCall.apiLike(marchant_id: merchantId!, image_id: image_id);
    ResponseData responseData = ResponseData.fromJson(res);
    log("$res", name: "Like Photo API");

    if (responseData.statusCode!) {
      await apiCall.sendNotification(
        title: "Liked Image",
        body: "${userName?.trim()} liked Your Photo",
        to: res["result"]["device_id"],
        image: imageUrl,
      );
      return LikeData.fromJson(res['result']);
    } else {
      return likeDataEmpty;
    }
  }

  Future shareImage({required String marchant_id}) async {
    final res = await apiCall.apiShare(marchant_id: marchant_id);
    ResponseData responseData = ResponseData.fromJson(res);

    return responseData;
  }

  Future<dynamic> bookingService(
      {required String marchantId,
      required DateTime orderDate,
      required String time,
      required String totalAmount,
      required String completionTime,
      required String agentID,
      required String token,
      required String amount,
      required Set<MarchantServiceData> serviceList}) async {
    List<Map<String, String>> _data = [];
    for (int i = 0; i < serviceList.length; i++) {
      _data.add({
        "service_id": serviceList.elementAt(i).serviceid,
      });
    }
    log("$orderDate", name: "Order Book API Date");
    final res = await apiCall.apiAddBooking(
      marchantId: marchantId,
      orderDate: orderDate,
      time: time,
      token: token,
      amount: amount,
      agentID: agentID,
      serviceList: _data,
      totalAmount: totalAmount,
      completionTime: completionTime,
    );
    if (res["status_code"] == true) {
      await apiCall.sendNotification(
        title: "New Order",
        body: "$userName Book an Order",
        to: res["device_id"],
      );
    }
    return res;
  }
}
