import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/db/app_get_storage.dart';
import 'package:surveyor_app/features/home/home_screen.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/auth_repo.dart';

class LoginController extends GetxController {
  final enableLoginButton = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();

  _updateLoginButtonState() {
    enableLoginButton.value = email.text.isEmail && password.text.isNotEmpty;
  }

  void login() async {
    final emailText = email.text;
    final passwordText = password.text;

    AuthRepo authRepo = AuthRepo();

    try {
      final data = await authRepo.login(email: emailText, password: passwordText);
      User user = User.fromJson(data);
      await AppGetStorage().write('token', data['token']);
      await AppGetStorage().write('user', user.toJson());
      Get.toNamed(HomeScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Login Failed: ${e.toString()}'), duration: const Duration(seconds: 3)));
      return;
    }
  }

  @override
  void onInit() {
    super.onInit();
    email.addListener(_updateLoginButtonState);
    password.addListener(_updateLoginButtonState);
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
