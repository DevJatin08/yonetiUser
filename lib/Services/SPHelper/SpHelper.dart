

import 'package:userapp/Constant/Global.dart';

class SPHepler {
  setPref(String name, String data) {
    sharedPreferences.setString(name, data);
  }

   setPrefbool(String name, bool data) {
    sharedPreferences.setBool(name, data);
  }

  String? getPref(
    String name,
  ) {
    return sharedPreferences.getString(name);
  }
  bool? getPrefbool(
    String name,
  ) {
    return sharedPreferences.getBool(name);
  }

  removePref(String name) {
    sharedPreferences.clear();
  }
}
