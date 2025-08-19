import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/features/home/widgets/users_list_controller.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/user_repo.dart';

class AddUpdateUserController extends GetxController {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final userType = (-1).obs;
  final user = User().obs;
  final enableAddUpdateButton = false.obs;

  void _updateAddUpdateButtonState() {
    enableAddUpdateButton.value =
        name.text.isNotEmpty &&
        phone.text.isNumericOnly &&
        phone.text.length == 10 &&
        email.text.isEmail &&
        password.text.isNotEmpty &&
        userType.value != -1;
  }

  void addUpdateUser() async {
    user.value = User(name: name.text, mobileNo: int.tryParse(phone.text), email: email.text, userType: userType.value);

    try {
      UserRepo userRepo = UserRepo();
      await userRepo.addOrUpdateUser(userData: {...user.toJson(), "password": password.text, "status_id": AppConstants.userStatusPublished});
      if (Get.isRegistered<UsersListController>()) Get.find<UsersListController>().getUsers();
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Failed to load users: ${e.toString()}')));
    }
  }

  @override
  void onInit() {
    super.onInit();
    name.addListener(_updateAddUpdateButtonState);
    phone.addListener(_updateAddUpdateButtonState);
    email.addListener(_updateAddUpdateButtonState);
    password.addListener(_updateAddUpdateButtonState);
    userType.listen((_) => _updateAddUpdateButtonState());
  }

  @override
  void onClose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
