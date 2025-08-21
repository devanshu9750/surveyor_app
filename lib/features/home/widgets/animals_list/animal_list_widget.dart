import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/features/home/home_controller.dart';
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
                    return ListTile(
                      onTap: () => Get.toNamed('/add-update-animal', arguments: animal),
                      title: Text(animal.ownerName ?? ''),
                      subtitle: Text("Tag: ${animal.tagNumber ?? ''}"),
                      trailing: Get.find<HomeController>().user.value?.userType == AppConstants.adminUserTypeID
                          ? PopupMenuButton(
                              itemBuilder: (_) {
                                return [
                                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                                  if (animal.isSpotInitiated == false) PopupMenuItem(value: 'initiate_spot', child: Text('Initiate Spot')),
                                ];
                              },
                              onSelected: (value) {
                                switch (value) {
                                  case 'edit':
                                    Get.toNamed('/add-update-animal', arguments: animal);
                                    break;
                                  case 'initiate_spot':
                                    controller.initiateSpot(animal.id!);
                                    break;
                                }
                              },
                            )
                          : null,
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
