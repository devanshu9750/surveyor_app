import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/addUpdateUser/add_update_user_screen.dart';
import 'package:surveyor_app/features/home/widgets/users_list_controller.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersListController>(
      init: UsersListController(),
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.userFilters.isEmpty
                    ? const Center(child: Text("No users found"))
                    : ListView.builder(
                        itemCount: controller.userList.length,
                        itemBuilder: (context, index) {
                          final user = controller.userList[index];
                          return GestureDetector(
                            onTap: () => Get.toNamed(AddUpdateUserScreen.routeName, arguments: user),
                            child: ListTile(
                              title: Text(user.name ?? ''),
                              subtitle: Text(user.email ?? ''),
                              trailing: IconButton(
                                onPressed: () => controller.showRemoveUserDialogue(user),
                                icon: const Icon(Icons.delete_outline_rounded),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
              width: double.infinity,
              decoration: BoxDecoration(color: context.theme.primaryColor.withValues(alpha: 0.1)),
              child: Wrap(
                spacing: 2.w,
                children: List.generate(
                  controller.userFilters.length,
                  (index) => Obx(
                    () => ChoiceChip(
                      label: Text(controller.userFilters[index]),
                      selected: controller.selectedUserFilter.value == controller.userFilters[index],
                      onSelected: (selected) {
                        if (selected) {
                          controller.toggleUserFilter(controller.userFilters[index]);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
