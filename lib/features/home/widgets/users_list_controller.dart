import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/user_repo.dart';

class UsersListController extends GetxController {
  final userFilters = [UserTypeFilter.all, UserTypeFilter.staff, UserTypeFilter.tpa];
  final selectedUserFilter = UserTypeFilter.all.obs;
  final userList = <User>[].obs;

  void toggleUserFilter(String value) => selectedUserFilter.value = value;

  void _toggleUsers(String userType) {
    if (userType == UserTypeFilter.all) {
      _getUsers(userType: [AppConstants.staffUserTypeID, AppConstants.tpaUserTypeID]);
    } else if (userType == UserTypeFilter.tpa) {
      _getUsers(userType: [AppConstants.tpaUserTypeID]);
    } else {
      _getUsers(userType: [AppConstants.staffUserTypeID]);
    }
  }

  void _getUsers({List<int> userType = const [2, 3]}) async {
    UserRepo userRepo = UserRepo();

    try {
      var data = await userRepo.getUsers(userType: userType, statusID: 1);
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
    _getUsers();
    selectedUserFilter.listen(_toggleUsers);
  }
}

sealed class UserTypeFilter {
  static const String all = "All";
  static const String staff = "Staff";
  static const String tpa = "TPA";
}
