import 'dart:developer';

import 'package:dio/dio.dart';

class ResponseMessage {
  display(String url, Response<dynamic> response) {
    log('*** URL response ***');
    log("URL = ${url}");
    log(response.toString());
    log('*******');
  }
}
