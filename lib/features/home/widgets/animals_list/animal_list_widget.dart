import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/features/home/widgets/animals_list/animal_list_controller.dart';

class AnimalListWidget extends StatelessWidget {
  const AnimalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimalListController>(
      init: AnimalListController(),
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.animalList.length,
                  itemBuilder: (context, index) {
                    final animal = controller.animalList[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed('/add-update-animal', arguments: animal),
                      child: ListTile(title: Text(animal.ownerName ?? ''), subtitle: Text("Tag: ${animal.tagNumber ?? ''}")),
                    );
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
