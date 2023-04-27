import 'package:flutter/cupertino.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/AboutYoneti/AboutYoneti.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class AboutYonetiService extends ChangeNotifier {
  AboutYonetis aboutYonetiEmpty =
      AboutYonetis(websiteAddress: "", termsOfServices: "", privacyPolicy: "", license: "");
  Future<AboutYonetis> getAboutYoneti() async {
    final res = await apiCall.apiAboutYoneti();
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      return AboutYonetis.fromJson(res['result']);
    } else {
      return aboutYonetiEmpty;
    }
  }
}
