import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/features/home/widgets/staff_animal_list/staff_animal_list_controller.dart';

class StaffAnimalListWidget extends StatelessWidget {
  const StaffAnimalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StaffAnimalListController(),
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.animalList.length,
                  itemBuilder: (context, index) {
                    final animal = controller.animalList[index];
                    return ListTile(title: Text(animal.ownerName ?? ''), subtitle: Text("Tag: ${animal.tagNumber ?? ''}"));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
