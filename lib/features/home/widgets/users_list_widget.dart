import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                () => ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    final user = controller.userList[index];
                    return ListTile(title: Text(user.name ?? ''), subtitle: Text(user.email ?? ''));
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: context.theme.primaryColor.withValues(alpha: 0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  controller.userFilters.length,
                  (index) => Obx(
                    () => Row(
                      children: [
                        Radio<String>(
                          groupValue: controller.selectedUserFilter.value,
                          value: controller.userFilters[index],
                          onChanged: (value) => controller.toggleFilter(value!),
                        ),
                        Text(controller.userFilters[index]),
                      ],
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
