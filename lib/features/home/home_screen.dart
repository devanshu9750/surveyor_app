import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/features/home/home_controller.dart';
import 'package:surveyor_app/features/home/widgets/users_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(leading: const Icon(Icons.menu), title: Text("Admin - ${controller.user.value?.name ?? ''}"), elevation: 10),
          floatingActionButton: controller.bottomBarIndex.value == 0 && controller.user.value?.userType == AppConstants.adminUserTypeID
              ? FloatingActionButton(onPressed: () => Get.toNamed('/add_user'), child: const Icon(Icons.add))
              : null,
          body: controller.user.value?.userType == AppConstants.adminUserTypeID
              ? Obx(() => IndexedStack(index: controller.bottomBarIndex.value, children: const [UsersListWidget(), SizedBox()]))
              : const SizedBox(),
          bottomNavigationBar: controller.user.value?.userType == AppConstants.adminUserTypeID
              ? Obx(
                  () => BottomNavigationBar(
                    elevation: 10,
                    onTap: (value) => controller.bottomBarIndex.value = value,
                    currentIndex: controller.bottomBarIndex.value,
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
                      BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Animal Policies'),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }
}
