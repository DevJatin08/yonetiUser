import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/User/UserData.dart';
import 'package:userapp/Services/SPHelper/SPConstant.dart';
import 'package:userapp/Services/api_client/APIConstant.dart';

class APICall {
  Dio dio = Dio(BaseOptions(baseUrl: baseURl));

  // String fakeid = "56";
  late UserData _userData;

  APICall() {
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["accesskey"] = "b8d7996ea3557791aba04cf51a0654b2";
    if (sharedPreferences.containsKey(userinfo_key)) {
      Map<String, dynamic> map = jsonDecode(sharedPreferences.getString(userinfo_key)!);
      _userData = UserData.fromJson(map);

      dio.options.headers["sessionid"] = _userData.sessionId;
    }
  }

  ///Send Notofication API
  Future sendNotification({required String body, String? title, required String to, String? image}) async {
    try {
      Map data = {
        "to": to,
        "notification": {
          "body": body,
          "title": title,
          "image": image,
        }
      };
      final response = await Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAr3EqWT8:APA91bGvV9X4qrN_hBpmF71eKyy0PalgP84QmeXM102Kx1iDx0X5zEYuQXjBfJb5UCQpp4vxb5NXNWKbWqjuUB5lKaeBeGwpe8zz_TkBdXFKJz2f0GT--hBU-UPCeIUiJm4DC6LydFDU',
          },
        ),
      ).post(url_notification, data: data);
      log("$response", name: "Notification Send");
      responseMessage.display(url_notification, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_login);
    }
  }

  ///User Login API
  Future apiLogin(
    String email,
    String password,
    String devicetoken,
  ) async {
    try {
      Map data = {
        "email": email,
        "password": password,
        "device_id": devicetoken,
        "device_type": platform,
        "is_push_notification": 1,
        "app_type": "user"
      };
      final response = await dio.post(url_login, data: data);
      responseMessage.display(url_login, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_login);
    }
  }

  Future apiSignIn(
    String email,
    String password,
    String phoneNumber,
    String devicetoken,
  ) async {
    try {
      Map data = {
        "email": email,
        "password": password,
        "phone_num": phoneNumber,
        "device_id": devicetoken,
        "device_type": platform,
        "is_push_notification": 1,
        "app_type": "user",
      };
      final response = await dio.post(url_singin, data: data);
      responseMessage.display(url_singin, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_singin);
    }
  }

  Future apiSendOTP(String id, String sesionId) async {
    try {
      dio.options.headers["sessionid"] = sesionId;
      Map data = {
        "user_id": id,
      };
      final response = await dio.post(url_sendOTP, data: data);
      responseMessage.display(url_sendOTP, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_sendOTP);
    }
  }

  Future apiVerifyOTP(String id, String verficationCode) async {
    try {
      print(verficationCode);
      Map data = {"id": id, "verificationcode": verficationCode};
      final response = await dio.post(url_verifyOTP, data: data);
      responseMessage.display(url_verifyOTP, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_verifyOTP);
    }
  }

  // forget password
  Future apiSendForgotPasswordEmail(String email, String sesionId) async {
    try {
      dio.options.headers["sessionid"] = sesionId;
      Map data = {"email": email};
      print(data);
      final response = await dio.post(url_sendForgotPasswordEmail, data: data);
      responseMessage.display(url_sendForgotPasswordEmail, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_sendForgotPasswordEmail);
    }
  }

  Future apiForgetVerifyOTP(String email, String verficationCode) async {
    try {
      Map data = {"email": email, "code": verficationCode};
      final response = await dio.post(url_forgetpassword_otp, data: data);
      responseMessage.display(url_forgetpassword_otp, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_forgetpassword_otp);
    }
  }

  Future apiForgetPassword(String email, String password) async {
    try {
      Map data = {"email": email, "newPassword": password};
      final response = await dio.post(url_forgetPassword, data: data);
      responseMessage.display(url_forgetPassword, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_forgetPassword);
    }
  }

  // profile
  Future apiGetProfile(
    String id,
  ) async {
    try {
      dio.options.headers["sessionid"] = '07512090aa3a558ae8aa66b65305aef5';
      Map data = {"user_id": id};

      final response = await dio.post(url_getProfile, data: data);
      responseMessage.display(url_getProfile, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getProfile);
    }
  }

  Future apiUpdateUserInfo(String name, String website, String userBio, String dob, String gender) async {
    try {
      // dio.options.headers["Sessionid"] = sessionId;

      Map data = {"user_id": _userData.userId, "fullname": name, "website": website, "user_bio": userBio, "dob": dob, "gender": gender};
      final response = await dio.post(url_updateProfile, data: data);
      responseMessage.display(url_updateProfile, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_updateProfile);
    }
  }

  Future apiUpdateUserAddress(
    String country,
    String city,
    String street,
    String zipCode,
  ) async {
    try {
      // dio.options.headers["Sessionid"] = sessionId;

      Map data = {
        "user_id": _userData.userId,
        "verificationcode": "022", // do not know the mean
        "country": country,
        "city": city,
        "street": street,
        "zip_code": zipCode
      };
      final response = await dio.post(url_updateAddress, data: data);
      responseMessage.display(url_updateAddress, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_updateAddress);
    }
  }

  Future apiUpdateAvatar(String imageString) async {
    try {
      Map data = {"user_id": _userData.userId, "avatar": imageString};

      final response = await dio.post(url_updateAvatar, data: data);
      responseMessage.display(url_updateAvatar, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_updateAvatar);
    }
  }

  Future apiUpdateCover({required String imageString}) async {
    try {
      Map data = {"user_id": _userData.userId, "cover_photo": imageString};

      final response = await dio.post(url_updateCoverPhoto, data: data);
      responseMessage.display(url_updateCoverPhoto, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_updateCoverPhoto);
    }
  }

  // order
  //{"user_id" : "6", "order_status" : "complete", "offset": 0, "limit" : 10 }
  Future apiGetActiveBookings() async {
    try {
      Map data = {"user_id": _userData.userId, "order_status": 'active', "offset": 0, "limit": 10};

      final response = await dio.post(url_getActiveBookings, data: data);
      responseMessage.display(url_getActiveBookings, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getActiveBookings);
    }
  }

  Future apiGetPastBookings() async {
    try {
      Map data = {"user_id": _userData.userId, "order_status": 'complete', "offset": 0, "limit": 10};

      final response = await dio.post(url_getPastBookings, data: data);
      responseMessage.display(url_getPastBookings, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getPastBookings);
    }
  }

// Home //
  Future apiHomeCategories() async {
    try {
      Map data = {
        "user_id": _userData.userId,
      };

      final response = await dio.post(url_homeGetCategories, data: data);
      responseMessage.display(url_homeGetCategories, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_homeGetCategories);
    }
  }

  Future apiGetMarchantList({required String categoryId}) async {
    try {
      Map data = {"user_id": _userData.userId, "category_id": categoryId};

      final response = await dio.post(url_getMarchantList, data: data);
      responseMessage.display(url_getMarchantList, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getMarchantList);
    }
  }

  Future apiGetMarchantAllDetails({required String marchantId}) async {
    try {
      Map data = {"user_id": marchantId, "category_id": "1"};

      final response = await dio.post(url_getMarchantAllDetails, data: data);
      // log("dcndiocndincdn" + response.data);
      responseMessage.display(url_getMarchantAllDetails, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getMarchantAllDetails);
    }
  }

  Future apiChangePassword(String newPassword, String oldPassword) async {
    try {
      Map data = {"user_id": _userData.userId, "oldPassword": oldPassword, "newPassword": newPassword};

      final response = await dio.post(url_changePassword, data: data);
      responseMessage.display(url_changePassword, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_changePassword);
    }
  }

  // Top Finder //
  Future apiTopReviews() async {
    try {
      Map data = {
        "user_id": _userData.userId,
      };

      final response = await dio.post(url_topreviews, data: data);
      responseMessage.display(url_topreviews, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_topreviews);
    }
  }

  Future apiUpdateNotification({required String notificationId}) async {
    try {
      Map data = {"notification_id": notificationId};
      final response = await dio.post(url_updateNotification, data: data);
      responseMessage.display(url_updateNotification, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_updateNotification);
    }
  }

  Future apiNotifications(int type) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "notification_type": type,
        "offset": 0,
        "limit": 10,
      };

      final response = await dio.post(url_getNotifications, data: data);
      responseMessage.display(url_getNotifications, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getNotifications);
    }
  }

  Future apiBookmark({int? offset, int? limit}) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "offset": offset,
        "limit": limit,
      };

      final response = await dio.post(url_getBookmark, data: data);
      responseMessage.display(url_getBookmark, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getBookmark);
    }
  }

  Future apiShare({required String marchant_id}) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "marchant_id": marchant_id,
      };
      final response = await dio.post(url_shares, data: data);
      responseMessage.display(url_shares, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_shares);
    }
  }

  Future apiLike({required String marchant_id, required String image_id}) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "marchant_id": marchant_id,
        "image_id": image_id,
      };

      final response = await dio.post(url_likePhoto, data: data);
      responseMessage.display(url_likePhoto, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_likePhoto);
    }
  }

  Future apiAddReview({
    required String merchantId,
    required String orderId,
    required String comment,
    required String rating,
  }) async {
    try {
      Map data = {"user_id": _userData.userId, "marchant_id": merchantId, "order_id": orderId, "comments": comment, "rating": rating};
      log("$data", name: "Review API Data");
      final response = await dio.post(url_addReview, data: data);

      responseMessage.display(url_addReview, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_addReview);
    }
  }

  Future apiAddCommentPhoto({required String marchant_id, required String image_id, required String comments}) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "marchant_id": marchant_id,
        "image_id": image_id,
        "comments": comments,
      };
      print("Comment " + data.toString());
      print(data);
      final response = await dio.post(url_addCommentPhoto, data: data);

      responseMessage.display(url_addCommentPhoto, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_addCommentPhoto);
    }
  }

  Future apiGetComments({required String ImageID}) async {
    try {
      Map data = {"image_id": ImageID, "offset": 0, "limit": 10};
      print(data);
      final response = await dio.post(url_getComments, data: data);
      responseMessage.display(url_getComments, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getComments);
    }
  }

  Future apiFilter({
    required int opennow,
    required double lat,
    required double long,
    required int rateing,
    required int nearest,
    required int cost_low_to_high,
    required int cost_high_to_low,
    required int homeservice,
  }) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "offset": 0,
        "limit": 10,
        "filters": {
          "quick_filters": {"open_now": opennow, "lat": lat, "lng": long, "rating": rateing},
          "sort_by": {"nearest": nearest, "cost_low_to_high": cost_low_to_high, "cost_high_to_low": cost_high_to_low},
          "list_by": {"home_service": homeservice}
        }
      };
      print(data);
      final response = await dio.post(url_filters, data: data);
      responseMessage.display(url_filters, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_filters);
    }
  }

  Future apiUserDiscovery({double? lat, double? long}) async {
    log("${_userData.userId}", name: "User ID");
    log("${lat}", name: "Latitude");
    log("${long}", name: "Longitude");
    try {
      Map data = {"user_id": _userData.userId, "lat": "$lat", "long": "$long", "is_permission": true};
      print(data);
      final response = await dio.post(url_getUserDiscovery, data: data);
      responseMessage.display(url_getUserDiscovery, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getUserDiscovery);
    }
  }

  Future apiGetPhotoLikeDetails({String? ImageID}) async {
    // fakeid
    try {
      Map data = {"image_id": ImageID, "offset": 0, "limit": 100};

      final response = await dio.post(url_getPhotoLikeDetails, data: data);
      responseMessage.display(url_getPhotoLikeDetails, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getPhotoLikeDetails);
    }
  }

  Future apiGetBookmark() async {
    try {
      Map data = {
        "user_id": _userData.userId,
      };
      print(data);
      final response = await dio.post(url_getBookmark, data: data);
      responseMessage.display(url_getBookmark, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getBookmark);
    }
  }

  Future apiGetAlbumByUser({required String merchatId}) async {
    try {
      //fakeid
      Map data = {
        "user_id": merchatId, //give user_id = merchat_id
      };

      final response = await dio.post(url_getAlbumByUser, data: data);
      responseMessage.display(url_getAlbumByUser, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getAlbumByUser);
    }
  }

  Future apiGetImagesAgainstUser({required String merchatId}) async {
    try {
      //fakeid
      Map data = {"user_id": merchatId, "offset": 0, "limit": 10}; //give user_id = merchat_id
      final response = await dio.post(url_getImagesAgainstUser, data: data);
      responseMessage.display(url_getImagesAgainstUser, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getImagesAgainstUser);
    }
  }

  Future apiGetImages({required String albumId}) async {
    try {
      //fakeid
      Map data = {"album_id": albumId, "offset": 0, "limit": 10};

      final response = await dio.post(url_getImages, data: data);
      responseMessage.display(url_getImages, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getImages);
    }
  }

  Future apiAddBookmark({required String business_id}) async {
    try {
      Map data = {"user_id": _userData.userId, "business_id": business_id};
      print(data);
      final response = await dio.post(url_addBookmark, data: data);
      responseMessage.display(url_addBookmark, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_addBookmark);
    }
  }

  Future apiDeleteBookmark({required String business_id}) async {
    try {
      Map data = {"id": business_id, "user_id": _userData.userId};
      print(data);
      final response = await dio.post(url_deleteBookmark, data: data);
      responseMessage.display(url_deleteBookmark, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_deleteBookmark);
    }
  }

  Future apiAddMarchantProfile({
    required String fullname,
    // required String website,
    required String user_bio,
    required String dob,
    required String gender,
  }) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "fullname": fullname,
        "website": "",
        "user_bio": user_bio,
        "dob": dob,
        "gender": gender,
      };
      print(data);
      final response = await dio.post(url_addMarchantProfile, data: data);
      responseMessage.display(url_addMarchantProfile, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_addMarchantProfile);
    }
  }

  Future apiTopPhotos() async {
    try {
      Map data = {
        "user_id": _userData.userId,
      };
      log("${_userData.userId}", name: "User ID");
      final response = await dio.post(url_topPhotos, data: data);
      responseMessage.display(url_topPhotos, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_topPhotos);
    }
  }

  Future apibookingservice() async {
    try {
      Map data = {"user_id": _userData.userId, "category_id": "2"};
      print(data);
      final response = await dio.post(url_getCategoryServices, data: data);
      responseMessage.display(url_getCategoryServices, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getCategoryServices);
    }
  }

  Future apiServiceAgainstCategory({
    required String marchantId,
  }) async {
    try {
      Map data = {"user_id": marchantId, "category_id": "1"};

      final response = await dio.post(url_getServiceAgainstCategory, data: data);
      responseMessage.display(url_getServiceAgainstCategory, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getServiceAgainstCategory);
    }
  }

  Future apiAllReviews({
    required String marchant_id,
    // required String type,
    // required String offset,
    // required String limit
  }) async {
    try {
      Map data = {"user_id": _userData.userId, "marchant_id": marchant_id, "type": "review", "offset": 0, "limit": 10};
      log("wdnwdnjbjkbd" + _userData.userId.toString());
      log("wdnwdnjbjkbd==" + marchant_id);
      print(data);
      final response = await dio.post(url_getAllReviews, data: data);
      // log("wdnwdnjbjkbd" + response.data);
      responseMessage.display(url_getAllReviews, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getAllReviews);
    }
  }

  Future apiOrderDetails({
    required String order_id,
    // required String type,
    // required String offset,
    // required String limit
  }) async {
    try {
      Map data = {"order_id": order_id, "offset": 0, "limit": 10};
      print(data);
      final response = await dio.post(url_orderDetails, data: data);
      responseMessage.display(url_orderDetails, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_orderDetails);
    }
  }

//Common
  Future apiAboutYoneti() async {
    try {
      Map data = {"user_id": _userData.userId};
      print(data);
      final response = await dio.post(url_aboutyoneti, data: data);
      responseMessage.display(url_aboutyoneti, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_aboutyoneti);
    }
  }

  Future apiChat({required String userId, required String chat_text}) async {
    try {
      Map data = {"user_id": _userData.userId, "marchant_id": userId, "app_type": _userData.userType, "chat_text": chat_text};
      log("jfhjghghj" + data.toString());
      final response = await dio.post(url_chat, data: data);
      // responseMessage.display(url_chat, response);
      log("$response", name: "Chat To Merchant");
      return response.data;
    } catch (e) {
      // errorDisplay.display(e, url_chat);
    }
  }

  Future getChatList() async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "app_type": "user",
      };
      final response = await dio.post(url_getChatLIst, data: data);
      // responseMessage.display(url_chat, response);
      return response.data;
    } catch (e) {
      // errorDisplay.display(e, url_chat);
    }
  }

  Future apiGetChat({
    required String userid,
  }) async {
    try {
      Map data = {"user_id": _userData.userId, "marchant_id": userid, "app_type": _userData.userType};

      final response = await dio.post(url_getChat, data: data);
      print('datara ${response}');
      responseMessage.display(url_getChat, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getChat);
    }
  }

  Future apiAddCard({required String card_no, required String expire, required String holder_name, required String cvv}) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "app_type": _userData.userType,
        "card_no": card_no,
        "expired": expire,
        "card_holder_name": holder_name,
        "cvv": cvv
      };
      print(data);
      final response = await dio.post(url_addCardInfo, data: data);
      responseMessage.display(url_addCardInfo, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_addCardInfo);
    }
  }

  Future apiGetCardInfo() async {
    try {
      Map data = {"user_id": _userData.userId, "app_type": _userData.userType};
      print(data);
      final response = await dio.post(url_getCardInfo, data: data);
      responseMessage.display(url_getCardInfo, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getCardInfo);
    }
  }

  Future apiFeedback({required String feedback}) async {
    try {
      Map data = {"user_id": _userData.userId, "app_type": _userData.userType, "feedback": feedback};
      print(data);
      final response = await dio.post(url_feedbackSupport, data: data);
      responseMessage.display(url_feedbackSupport, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_feedbackSupport);
    }
  }

  Future reservation({required String marchantId}) async {
    try {
      Map data = {
        "user_id": marchantId,
      };
      print("...res..." + data.toString());
      final response = await dio.post(url_Reserve, data: data);
      responseMessage.display(url_Reserve, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_Reserve);
    }
  }

  Future apiAddBooking(
      {required String marchantId,
      required DateTime orderDate,
      required String time,
      required String agentID,
      required String totalAmount,
      required String completionTime,
      required List<Map<String, String>> serviceList}) async {
    try {
      String _orderDate = "${orderDate.year}-${orderDate.month}-${orderDate.day}";
      log("${orderDate}", name: "API Calling Date");
      Map data = {
        "user_id": _userData.userId,
        "marchant_id": marchantId,
        "booking_date": _orderDate,
        "booking_time": time,
        "agent_id": agentID,
        "services": serviceList,
        "total_amount": totalAmount,
        "completion_time": completionTime,
      };
      log("$data", name: "Booking Data");
      //{

      // "user_id": "11",
      // "marchant_id": "12",
      // "order_date": "2022-10-12",
      // "order_time": "23:10:00",
      // "agent_id": "",
      // "services": [
      //   {"service_id": "18"},
      //   {"service_id": "23"}
      // ]
      // "user_id": _userData.userId,
      // "marchant_id": marchantId,
      // "order_date": _orderDate,
      // "order_time": time,
      // "agent_id": agentID,
      // "services": serviceList
      // };

      log("ffgfgfrr" + data.toString());
      log("ffgfgfrr" + serviceList.toString());
      final response = await dio.post(url_addBooking, data: data);
      print("reservation" + response.toString());
      responseMessage.display(url_addBooking, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_addBooking);
    }
  }

// Future apibookingdetails({required String marchant_id}) async {
//   try {
//     Map data = {
//       "user_id": _userData.userId,
//       "marchant_id": "49",
//       "order_date": "2021-10-18",
//       // "order_date": "2021-10-18",
//       "order_time": "23:10:00",
//       // "order_time": "23:10:00",
//       "agent_id": "",
//       "services": [
//         {"service_id": "55"},
//         {"service_id": "57"},
//         {"service_id": "4"}
//       ]
//     };
//     print(data);
//     final response = await dio.post(url_topPhotos, data: data);
//     responseMessage.display(url_topPhotos, response);
//     return response.data;
//   } catch (e) {
//     errorDisplay.display(e, url_topPhotos);
//   }
// }
  Future apiCounterNotification() async {
    try {
      Map data = {"user_id": _userData.userId};

      final response = await dio.post(url_getNotificationCount, data: data);

      responseMessage.display(url_getNotificationCount, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_getNotificationCount);
    }
  }

  Future apiSendTestPushNotification({required String deviceId}) async {
    try {
      Map data = {"device_id": deviceId};

      log(data.toString());
      log(deviceId.toString());

      final response = await dio.post(url_sendTestPushNotification, data: data);

      responseMessage.display(url_sendTestPushNotification, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_sendTestPushNotification);
    }
  }

  Future apiSwapBooking({required String swap_user_id, required String user_booking_id, required String swap_user_booking_id}) async {
    try {
      Map data = {
        "user_id": _userData.userId,
        "swap_user_id": swap_user_id,
        "user_booking_id": user_booking_id,
        "swap_user_booking_id": swap_user_booking_id
      };

      final response = await dio.post(url_swapBooking, data: data);

      responseMessage.display(url_swapBooking, response);
      return response.data;
    } catch (e) {
      errorDisplay.display(e, url_swapBooking);
    }
  }
}
