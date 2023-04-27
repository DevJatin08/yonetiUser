import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';

class SwapBookingService extends ChangeNotifier {
  String snack = "";
  Future SwapBooking(
      {required BuildContext context,
      required String swap_user_id,
      required String user_booking_id,
      required String swap_user_booking_id}) async {
    final res = await apiCall.apiSwapBooking(
        swap_user_id: swap_user_id,
        user_booking_id: user_booking_id,
        swap_user_booking_id: swap_user_booking_id);
    snack = res["message"];
    log(snack);

    ResponseData responseData = ResponseData.fromJson(res);

    // snackbar(responseData.message.toString(), context!);
  }
}
