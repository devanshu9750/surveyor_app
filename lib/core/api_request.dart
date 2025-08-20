import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiRequest extends GetConnect {
  static final ApiRequest _instance = ApiRequest._internal();
  factory ApiRequest() => _instance;
  ApiRequest._internal();

  Future<Response> postRequest(String url, dynamic body) async {
    final response = await post(url, body);
    if (kDebugMode) {
      print('POST $url: $body');
      print('Response: ${response.body}');
    }
    return response;
  }
}
