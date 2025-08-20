import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/user_repo.dart';

class UsersListController extends GetxController {
  final userFilters = [UserTypeFilter.all, UserTypeFilter.staff, UserTypeFilter.tpa];
  final selectedUserFilter = UserTypeFilter.all.obs;
  final userList = <User>[].obs;
  final isLoading = true.obs;

  void toggleUserFilter(String value) => selectedUserFilter.value = value;

  void _toggleUsers(String userType) {
    if (userType == UserTypeFilter.all) {
      getUsers(userType: [AppConstants.staffUserTypeID, AppConstants.tpaUserTypeID]);
    } else if (userType == UserTypeFilter.tpa) {
      getUsers(userType: [AppConstants.tpaUserTypeID]);
    } else {
      getUsers(userType: [AppConstants.staffUserTypeID]);
    }
  }

  void getUsers({List<int> userType = const [2, 3]}) async {
    UserRepo userRepo = UserRepo();

    try {
      isLoading.value = true;
      final data = await userRepo.getUsers(userType: userType, statusID: 1);
      userList.value = (data['users'] as List).map((user) => User.fromJson(user)).toList();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Failed to load users: ${e.toString()}')));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
    selectedUserFilter.listen(_toggleUsers);
  }
}

sealed class UserTypeFilter {
  static const String all = "All";
  static const String staff = "Staff";
  static const String tpa = "TPA";
}
