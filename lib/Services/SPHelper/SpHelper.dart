

import 'package:userapp/Constant/Global.dart';

class SPHepler {
  setPref(String name, String data) {
    sharedPreferences.setString(name, data);
  }

  String? getPref(
    String name,
  ) {
    return sharedPreferences.getString(name);
  }

  removePref(String name) {
    sharedPreferences.clear();
  }
}
