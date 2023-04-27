import 'package:flutter/widgets.dart';
import 'package:userapp/Model/Order/ActiveOrder.dart';
import 'package:userapp/Model/Order/OrderDetails.dart';
import 'package:userapp/Model/Order/PastOrder.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Services/api_client/APICall.dart';

class OrderSrervice extends ChangeNotifier {
  ActiveOrder empty = ActiveOrder(orders: []);
  ActiveOrder activtOrderList = ActiveOrder(orders: []);
  PastOrder pastOrderList = PastOrder(pastBooking: []);
  PastOrder emptypast = PastOrder(pastBooking: []);
  OrderDetails orderDetailsEmpty = OrderDetails(
      orderId: "",
      marchantId: "",
      date: "",
      orderDate: "",
      endTime: "",
      startTime: "",
      serviceCount: 0,
      userName: "",
      userAddress: "",
      userEmail: "",
      userZipCode: "",
      phoneNum: "",
      orderStatus: "",
      marchantRating: 0,
      userPic: "",
      coverPhoto: "",
      orderDetails: []);
  APICall apiCall = APICall();

  Future activeOrder() async {
    final res = await apiCall.apiGetActiveBookings();
    ResponseData responseData = ResponseData.fromJson(res);
    activtOrderList = ActiveOrder(orders: []);
    if (responseData.statusCode!) {
      activtOrderList = ActiveOrder.fromJson(res['result']);
      notifyListeners();
      // return activtOrderList;
    }
  }

  Future pastOrder() async {
    pastOrderList = PastOrder(pastBooking: []);
    final res = await apiCall.apiGetPastBookings();
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      pastOrderList = PastOrder.fromJson(res['result']);
      notifyListeners();
    }
  }

  Future<OrderDetails> orderDetails({required String order_id}) async {
    final res = await apiCall.apiOrderDetails(order_id: order_id);
    orderDetailsEmpty = OrderDetails.fromJson(res['result']);
    return orderDetailsEmpty;
  }
}
