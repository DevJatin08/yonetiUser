import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Model/User/UserData.dart';
import 'package:userapp/Services/SPHelper/SPConstant.dart';
import 'package:userapp/Services/api_client/APICall.dart';

class UserService extends ChangeNotifier {
  UserData userData = UserData();
  APICall apiCall = APICall();
  bool isLogin = false;
  ResponseData defaultErrorResponse =
      ResponseData(message: 'object', statusCode: false);

  UserService() {
    intialize();
  }

  intialize() async {
    // sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(userinfo_key)) {
      Map<String, dynamic> map =
          jsonDecode(sharedPreferences.getString(userinfo_key)!);
      // get userInfo from Shared Preference
      UserData spUserData = UserData.fromJson(map);
      // refetch data from api
      final res = await apiCall.apiGetProfile(spUserData.userId.toString());
      userData = UserData.fromJson(res['result']);
      spHepler.setPref(userinfo_key, jsonEncode(userData.toJson()));

      isLogin = true;

      notifyListeners();
    }
  }

  signOut() {
    spHepler.removePref(userinfo_key);

    isLogin = false;
    notifyListeners();
  }

  Future<ResponseData> callLogin(
    String email,
    String password,
    String devicetoken,
  ) async {
    try {
      final res = await apiCall.apiLogin(email, password, devicetoken);
      ResponseData responseData = ResponseData.fromJson(res);
      if (responseData.statusCode!) {
        userData = UserData.fromJson(res['result']);
        spHepler.setPref(userinfo_key,
            jsonEncode(userData.toJson())); // TODO: remove line after testing
        spHepler.setPref(userinfo_key, jsonEncode(userData.toJson()));
        await apiCall.apiSendOTP(userData.userId!, userData.sessionId!);
      }
      notifyListeners();
      return responseData;
    } catch (e) {
      print('callLogin error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> callSignIn(
    String email,
    String password,
    String phoneNumber,
    String devicetoken,
  ) async {
    try {
      final res =
          await apiCall.apiSignIn(email, password, phoneNumber, devicetoken);
      ResponseData responseData = ResponseData.fromJson(res);

      return responseData;
    } catch (e) {
      print('callSignIn error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> callSocialLogin(
    String email,
    String token,
    String socialType,
    String devicetoken,
    String deviceId,
  ) async {
    try {
      final res = await apiCall.apiSocialLogin(
          email, token, socialType, devicetoken, deviceId);
      ResponseData responseData = ResponseData.fromJson(res);
      isLogin = responseData.statusCode!;
      if (responseData.statusCode!) {
        userData = UserData.fromJson(res['result']);
        spHepler.setPref(userinfo_key, jsonEncode(userData.toJson()));
      }
      notifyListeners();
      return responseData;
    } catch (e) {
      print('callSignIn error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> verifyOTP(
    String OTP,
  ) async {
    try {
      final res = await apiCall.apiVerifyOTP(userData.userId!, OTP);
      ResponseData responseData = ResponseData.fromJson(res);
      isLogin = responseData.statusCode!;
      if (responseData.statusCode!) {
        spHepler.setPref(userinfo_key, jsonEncode(userData.toJson()));
      }
      notifyListeners();
      return responseData;
    } catch (e) {
      print('callSignIn error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future sendOTP() async {
    await apiCall.apiSendOTP(userData.userId!, userData.sessionId!);
  }

  Future<ResponseData> chnagePassword(
    String newpassword,
    String oldPassword,
  ) async {
    try {
      final res = await apiCall.apiChangePassword(newpassword, oldPassword);
      ResponseData responseData = ResponseData.fromJson(res);

      return responseData;
    } catch (e) {
      print('callSignIn error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> chnagePasswordOTPVerify(
    String OTP,
  ) async {
    try {
      print("String=" + OTP);
      final res = await apiCall.apiVerifyOTP(userData.userId!, OTP);
      print('response = ${res}');
      ResponseData responseData = ResponseData.fromJson(res);

      return responseData;
    } catch (e) {
      print('callSignIn error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> sendForgotPasswordEmail(
    String email,
  ) async {
    try {
      final res = await apiCall.apiSendForgotPasswordEmail(
          email, userData.sessionId.toString());
      ResponseData responseData = ResponseData.fromJson(res);

      return responseData;
    } catch (e) {
      print('sendForgotPasswordEmail = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> forgetPassword_otp_verification(
    String email,
    String OTP,
  ) async {
    try {
      final res = await apiCall.apiForgetVerifyOTP(email, OTP);
      ResponseData responseData = ResponseData.fromJson(res);

      return responseData;
    } catch (e) {
      print('callSignIn error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> forgetPassword(
    String email,
    String password,
  ) async {
    try {
      final res = await apiCall.apiForgetPassword(email, password);
      ResponseData responseData = ResponseData.fromJson(res);

      return responseData;
    } catch (e) {
      print('callSignIn error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> updateUserInfo(
    String name,
    // String website,
    String userBio,
    String dob,
    String gender,
  ) async {
    try {
      final res =
          await apiCall.apiUpdateUserInfo(name, "", userBio, dob, gender);
      ResponseData responseData = ResponseData.fromJson(res);
      isLogin = responseData.statusCode!;
      if (responseData.statusCode!) {
        userData = UserData.fromJson(res['result']);
        spHepler.setPref(userinfo_key, jsonEncode(userData.toJson()));
      }
      notifyListeners();
      return responseData;
    } catch (e) {
      print('updateUserInfo error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> updateAvatar(
    String imageString,
  ) async {
    try {
      final res = await apiCall.apiUpdateAvatar(imageString);
      ResponseData responseData = ResponseData.fromJson(res);
      isLogin = responseData.statusCode!;
      if (responseData.statusCode!) {
        userData = UserData.fromJson(res['result']);
        spHepler.setPref(userinfo_key, jsonEncode(userData.toJson()));
      }
      notifyListeners();
      return responseData;
    } catch (e) {
      print('updateAvatar error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future<ResponseData> updateCover(
    String imageString,
  ) async {
    try {
      final res = await apiCall.apiUpdateCover(imageString: imageString);
      ResponseData responseData = ResponseData.fromJson(res);
      isLogin = responseData.statusCode!;
      if (responseData.statusCode!) {
        userData = UserData.fromJson(res['result']);
        spHepler.setPref(userinfo_key, jsonEncode(userData.toJson()));
      }
      notifyListeners();
      return responseData;
    } catch (e) {
      print('updateCover error = ${e}');
      return defaultErrorResponse;
    }
  }

  Future getAccountSetting({
    required String fullname,
    // required String website,
    required String user_bio,
    required String dob,
    required String gender,
  }) async {
    final res = await apiCall.apiAddMarchantProfile(
        // website: website,
        fullname: fullname,
        dob: dob,
        gender: gender,
        user_bio: user_bio);
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode == true) {
      userData.fullname = fullname;
      // userData.website = website;
      userData.dob = dob;
      userData.gender = gender;
      userData.userBio = user_bio;
    }
    notifyListeners();
  }
}
