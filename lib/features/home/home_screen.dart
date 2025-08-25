import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/addUpdateAnimal/add_update_animal_screen.dart';
import 'package:surveyor_app/features/addUpdateUser/add_update_user_screen.dart';
import 'package:surveyor_app/features/home/home_controller.dart';
import 'package:surveyor_app/features/home/widgets/animals_list/animal_list_controller.dart';
import 'package:surveyor_app/features/home/widgets/animals_list/animal_list_widget.dart';
import 'package:surveyor_app/features/home/widgets/staff_animal_list/staff_animal_list_widget.dart';
import 'package:surveyor_app/features/home/widgets/tpa_animal_list/tpa_animal_list_widget.dart';
import 'package:surveyor_app/features/home/widgets/users_list/users_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: Center(
                    child: controller.isAdmin
                        ? Text('Admin - ${controller.user.value?.name ?? ''}')
                        : controller.isStaff
                        ? Text('Staff - ${controller.user.value?.name ?? ''}')
                        : Text('TPA - ${controller.user.value?.name ?? ''}'),
                  ),
                ),
                ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), onTap: () => controller.logout()),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              "${controller.isAdmin
                  ? "Admin"
                  : controller.isStaff
                  ? "Staff"
                  : "TPA"} - ${controller.user.value?.name ?? ''}",
            ),
            actions: [
              if (controller.isAdmin)
                Obx(
                  () => controller.bottomBarIndex.value == 1
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: SearchAnchor(
                            searchController: controller.searchController,
                            builder: (_, _) => Icon(Icons.search),
                            suggestionsBuilder: (_, searchController) {
                              return [
                                Obx(
                                  () => ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.searchedAnimals.length,
                                    itemBuilder: (context, index) {
                                      final animal = controller.searchedAnimals[index];
                                      return ListTile(
                                        onTap: () => controller.searchedAnimalTap(animal),
                                        title: Text(animal.ownerName ?? ''),
                                        subtitle: Text(
                                          "Tag: ${animal.tagNumber ?? ''}\nStatus: ${animal.isSpotCompleted == true
                                              ? "SPOT COMPLETED"
                                              : animal.isSpotInitiated == true
                                              ? "SPOT INITIATED"
                                              : "CREATED"}",
                                        ),
                                        trailing: Get.find<HomeController>().isAdmin
                                            ? PopupMenuButton(
                                                itemBuilder: (_) {
                                                  return [
                                                    PopupMenuItem(
                                                      onTap: () => Get.toNamed('/add-update-animal', arguments: animal),
                                                      value: 'edit',
                                                      child: Text('Edit'),
                                                    ),
                                                    PopupMenuItem(
                                                      enabled: animal.isSpotInitiated == false,
                                                      onTap: () => Get.find<AnimalListController>().initiateSpot(animal.id!),
                                                      value: 'initiate_spot',
                                                      child: Text('Initiate Spot'),
                                                    ),
                                                  ];
                                                },
                                              )
                                            : null,
                                      );
                                    },
                                  ),
                                ),
                              ];
                            },
                          ),
                        )
                      : const SizedBox(),
                ),
            ],
          ),
          floatingActionButton: controller.isAdmin
              ? FloatingActionButton(
                  onPressed: () => controller.bottomBarIndex.value == 0
                      ? Get.toNamed(AddUpdateUserScreen.routeName)
                      : controller.bottomBarIndex.value == 1
                      ? Get.toNamed(AddUpdateAnimalScreen.routeName)
                      : null,
                  child: const Icon(Icons.add),
                )
              : null,
          body: controller.isAdmin
              ? Obx(() => IndexedStack(index: controller.bottomBarIndex.value, children: const [UsersListWidget(), AnimalListWidget()]))
              : controller.isStaff
              ? StaffAnimalListWidget()
              : const TpaAnimalListWidget(),
          bottomNavigationBar: controller.isAdmin
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
              : controller.isTPA
              ? Obx(
                  () => BottomNavigationBar(
                    elevation: 10,
                    onTap: (value) => controller.bottomBarIndex.value = value,
                    currentIndex: controller.bottomBarIndex.value,
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'In Progress'),
                      BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Completed'),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }
}
