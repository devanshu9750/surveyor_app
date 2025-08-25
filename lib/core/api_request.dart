import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ApiRequest extends GetConnect {
  static final ApiRequest _instance = ApiRequest._internal();
  factory ApiRequest() => _instance;
  ApiRequest._internal();

  Future<Response> postRequest(String url, Map<String, dynamic> body) async {
    final response = await post(url, body);
    if (kDebugMode) {
      print('POST $url: $body');
      print('Response: ${response.body}');
    }
    return response;
  }

  Future<Response> uploadFile(String url, Map<String, dynamic> body, String fileKey, XFile file) async {
    final FormData formData = FormData({fileKey: MultipartFile(await file.readAsBytes(), filename: file.name), ...body});
    final response = await post(url, formData);
    if (kDebugMode) {
      print('POST $url: $formData');
      print('Response: ${response.body}');
    }
    return response;
  }
}
