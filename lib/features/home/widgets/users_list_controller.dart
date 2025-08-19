import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/user_repo.dart';

class UsersListController extends GetxController {
  final userFilters = [UserTypeFilter.all, UserTypeFilter.staff, UserTypeFilter.tpa];
  final selectedUserFilter = UserTypeFilter.all.obs;
  final userList = <User>[].obs;

  void toggleFilter(String value) => selectedUserFilter.value = value;

  void getUsers() async {
    UserRepo userRepo = UserRepo();

    try {
      var data = await userRepo.getUsers(userType: [1], statusID: 1);
      userList.value = (data['users'] as List).map((user) => User.fromJson(user)).toList();
    } catch (e) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Failed to load users: ${e.toString()}'), duration: const Duration(seconds: 3)));
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }
}

sealed class UserTypeFilter {
  static const String all = "All";
  static const String staff = "Staff";
  static const String tpa = "TPA";
}
