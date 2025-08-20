import 'package:get/get.dart';

class ApiRequest extends GetConnect {
  static final ApiRequest _instance = ApiRequest._internal();
  factory ApiRequest() => _instance;
  ApiRequest._internal();

  Future<Response> postRequest(String url, dynamic body) async {
    final response = await post(url, body);
    return response;
  }
}
