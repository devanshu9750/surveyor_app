import 'package:get/get.dart';

class UsersListController extends GetxController {
  final userFilters = [UserTypeFilter.all, UserTypeFilter.staff, UserTypeFilter.tpa];
  final selectedUserFilter = UserTypeFilter.all.obs;

  void toggleFilter(String value) => selectedUserFilter.value = value;
}

sealed class UserTypeFilter {
  static const String all = "All";
  static const String staff = "Staff";
  static const String tpa = "TPA";
}
