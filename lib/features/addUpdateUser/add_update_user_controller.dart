import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/features/home/widgets/users_list/users_list_controller.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/user_repo.dart';

class AddUpdateUserController extends GetxController {
  final arguments = Get.arguments;
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final userType = 2.obs;
  final user = User().obs;
  final enableAddUpdateButton = false.obs;

  void _updateAddUpdateButtonState() {
    enableAddUpdateButton.value =
        name.text.isNotEmpty &&
        phone.text.isNumericOnly &&
        phone.text.length == 10 &&
        email.text.isEmail &&
        (password.text.isNotEmpty || user.value.id != null);
  }

  void addUpdateUser() async {
    if (user.value.id == null) {
      user.value = User(
        name: name.text,
        mobileNo: int.tryParse(phone.text),
        email: email.text,
        userType: userType.value,
        statusId: AppConstants.userStatusPublished,
      );
    } else {
      user.value = User.copyWith(user.value, name: name.text, mobileNo: int.tryParse(phone.text), email: email.text, userType: userType.value);
    }

    try {
      UserRepo userRepo = UserRepo();
      await userRepo.addOrUpdateUser(userData: {...user.toJson(), if (password.text.isNotEmpty) "password": password.text});
      if (Get.isRegistered<UsersListController>()) Get.find<UsersListController>().getUsers();
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Failed to load users: ${e.toString()}')));
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (arguments != null && arguments is User) {
      user.value = arguments as User;
      name.text = user.value.name ?? '';
      phone.text = user.value.mobileNo?.toString() ?? '';
      email.text = user.value.email ?? '';
      userType.value = user.value.userType ?? 2;
      _updateAddUpdateButtonState();
    }
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
