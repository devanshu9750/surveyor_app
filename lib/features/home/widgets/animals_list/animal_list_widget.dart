import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_extensions.dart';
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
                      subtitle: Text(
                        "Tag: ${animal.tagNumber ?? ''}\nStatus: ${animal.isSpotCompleted == true
                            ? 'SPOT COMPLETED'
                            : animal.isSpotInitiated == true
                            ? 'SPOT INITIATED'
                            : 'CREATED'}",
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
                                    onTap: () => controller.initiateSpot(animal.id!),
                                    value: 'initiate_spot',
                                    enabled: animal.isSpotInitiated == false,
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
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
              width: double.infinity,
              decoration: BoxDecoration(color: context.theme.primaryColor.withValues(alpha: 0.1)),
              child: Wrap(
                spacing: 2.w,
                children: List.generate(
                  controller.animalFilters.length,
                  (index) => Obx(
                    () => ChoiceChip(
                      label: Text(controller.animalFilters[index]),
                      selected: controller.selectedAnimalFilter.value == controller.animalFilters[index],
                      onSelected: (selected) {
                        if (selected) {
                          controller.toggleAnimalFilter(controller.animalFilters[index]);
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
