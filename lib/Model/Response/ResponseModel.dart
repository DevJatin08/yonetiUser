class ResponseData {
  ResponseData({
    this.statusCode,
    this.message,
  });

  bool? statusCode;
  String? message;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
      };
}
