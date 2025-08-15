import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/features/home/home_screen.dart';

class LoginController extends GetxController {
  final enableLoginButton = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();

  _updateLoginButtonState() {
    enableLoginButton.value = email.text.isEmail && password.text.isNotEmpty;
  }

  void login() {
    final emailText = email.text;
    final passwordText = password.text;

    // Implement your login logic here

    Get.offAllNamed(HomeScreen.routeName);
  }

  @override
  void onInit() {
    super.onInit();
    email.addListener(_updateLoginButtonState);
    password.addListener(_updateLoginButtonState);
  }
}
