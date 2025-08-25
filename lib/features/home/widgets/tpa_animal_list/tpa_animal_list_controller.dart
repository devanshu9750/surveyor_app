import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class TpaAnimalListController extends GetxController {
  final spotInProgressAnimals = <Animal>[].obs;
  final spotCompletedAnimals = <Animal>[].obs;

  void getSpotInProgressAnimals() async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      final data = await animalRepo.getAnimals(spotAnimals: true, spotAnimalsCompleted: false);
      List<dynamic> animalsData = data['animals'] ?? [];
      spotInProgressAnimals.value = animalsData.map((animalJson) => Animal.fromJson(animalJson)).toList();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error fetching spot in progress animals: $e')));
    }
  }

  void getSpotCompletedAnimals() async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      final data = await animalRepo.getAnimals(spotAnimals: true, spotAnimalsCompleted: true);
      List<dynamic> animalsData = data['animals'] ?? [];
      spotCompletedAnimals.value = animalsData.map((animalJson) => Animal.fromJson(animalJson)).toList();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error fetching spot completed animals: $e')));
    }
  }

  @override
  void onInit() {
    super.onInit();
    getSpotInProgressAnimals();
    getSpotCompletedAnimals();
  }
}
