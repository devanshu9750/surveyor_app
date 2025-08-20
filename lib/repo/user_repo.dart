import 'package:get/get.dart';
import 'package:surveyor_app/core/api_request.dart';
import 'package:surveyor_app/core/app_api.dart';
import 'package:surveyor_app/core/app_constants.dart';

class UserRepo extends GetConnect {
  UserRepo._privateConstructor();
  static final UserRepo _instance = UserRepo._privateConstructor();
  factory UserRepo() => _instance;

  Future<Map<String, dynamic>> addOrUpdateUser({required Map<String, dynamic> userData}) async {
    final response = await ApiRequest().postRequest(AppApi.addOrUpdateUser, userData);

    if (response.statusCode != 200) throw Exception('User save failed: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('User save failed: ${data['message']}');
    }

    return response.body;
  }

  Future<Map<String, dynamic>> getUsers({required List<int> userType, required int statusID}) async {
    final response = await ApiRequest().postRequest(AppApi.getUsers, {'user_type': userType, 'status_id': statusID});

    if (response.statusCode != 200) throw Exception('Get users failed: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Get users failed: ${data['message']}');
    }

    return data['contents'];
  }
}
