import 'package:get/get.dart';
import 'package:surveyor_app/core/app_api.dart';
import 'package:surveyor_app/core/app_constants.dart';

class AuthRepo extends GetConnect {
  AuthRepo._privateConstructor();
  static final AuthRepo _instance = AuthRepo._privateConstructor();
  factory AuthRepo() => _instance;

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    final response = await post(AppApi.requestAccountAccess, {'email': email, 'password': password});

    if (response.statusCode != 200) throw Exception('Login failed: ${response.body}');

    Map<String, dynamic> data = response.body;
    if (data['status'] == AppConstants.errorStatus) {
      throw Exception('Login failed: ${data['message']}');
    }

    return data['contents'];
  }
}
