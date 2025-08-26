import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/animalDetail/animal_detail_screen.dart';
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
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.animalList.isEmpty
                    ? const Center(child: Text('No animals found'))
                    : ListView.builder(
                        itemCount: controller.animalList.length,
                        itemBuilder: (context, index) {
                          final animal = controller.animalList[index];
                          return ListTile(
                            onTap: () => Get.toNamed(AnimalDetailScreen.routeName, arguments: animal.id),
                            title: Text(animal.ownerName ?? ''),
                            subtitle: Text(
                              "Tag: ${animal.tagNumber ?? ''} ${animal.isSpotCompleted == true
                                  ? '\nStatus: Spot Completed'
                                  : animal.isSpotInitiated == true
                                  ? '\nStatus: Spot Initiated'
                                  : ''}",
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
