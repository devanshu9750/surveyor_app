import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/features/animalDetail/animal_detail_screen.dart';
import 'package:surveyor_app/features/home/home_controller.dart';
import 'package:surveyor_app/features/home/widgets/tpa_animal_list/tpa_animal_list_controller.dart';

class TpaAnimalListWidget extends StatelessWidget {
  const TpaAnimalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return GetBuilder<TpaAnimalListController>(
      init: TpaAnimalListController(),
      builder: (controller) {
        return Obx(
          () => homeController.bottomBarIndex.value == 0
              ? controller.spotInProgressAnimals.isEmpty
                    ? const Center(child: Text('No Spot In Progress Animals'))
                    : ListView.builder(
                        itemCount: controller.spotInProgressAnimals.length,
                        itemBuilder: (context, index) {
                          final animal = controller.spotInProgressAnimals[index];

                          return ListTile(
                            onTap: () => Get.toNamed(AnimalDetailScreen.routeName, arguments: animal.id),
                            title: Text(animal.ownerName ?? ''),
                            subtitle: Text(animal.tagNumber ?? ''),
                          );
                        },
                      )
              : controller.spotCompletedAnimals.isEmpty
              ? const Center(child: Text('No Spot Completed Animals'))
              : ListView.builder(
                  itemCount: controller.spotCompletedAnimals.length,
                  itemBuilder: (context, index) {
                    final animal = controller.spotCompletedAnimals[index];

                    return ListTile(
                      onTap: () => Get.toNamed(AnimalDetailScreen.routeName, arguments: animal.id),
                      title: Text(animal.ownerName ?? ''),
                      subtitle: Text(animal.tagNumber ?? ''),
                    );
                  },
                ),
        );
      },
    );
  }
}
