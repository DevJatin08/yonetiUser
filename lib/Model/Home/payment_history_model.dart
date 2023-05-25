class PaymentHistoryModel {
  bool? statusCode;
  String? message;
  List<PaymentHistoryModelResult>? result;

  PaymentHistoryModel({this.statusCode, this.message, this.result});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <PaymentHistoryModelResult>[];
      json['result'].forEach((v) {
        result!.add(new PaymentHistoryModelResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentHistoryModelResult {
  String? userId;
  String? appType;
  String? amount;
  String? currency;
  String? paymentStatus;
  String? createdAt;

  PaymentHistoryModelResult(
      {this.userId,
      this.appType,
      this.amount,
      this.currency,
      this.paymentStatus,
      this.createdAt});

  PaymentHistoryModelResult.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    appType = json['app_type'];
    amount = json['amount'];
    currency = json['currency'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['app_type'] = this.appType;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
