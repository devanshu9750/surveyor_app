import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class AnimalListController extends GetxController {
  final page = 1.obs;
  final isLoading = true.obs;
  final allAnimals = <Animal>[].obs;
  final animalList = <Animal>[].obs;
  final animalFilters = [AnimalFilterType.all, AnimalFilterType.assigned, AnimalFilterType.unassigned];
  final selectedAnimalFilter = AnimalFilterType.all.obs;

  void toggleAnimalFilter(String value) => selectedAnimalFilter.value = value;

  void _toggleAnimals(String animalFilterType) {
    if (animalFilterType == AnimalFilterType.all) {
      animalList.value = allAnimals;
    } else if (animalFilterType == AnimalFilterType.assigned) {
      animalList.value = allAnimals.where((animal) => animal.staffId != null).toList();
    } else {
      animalList.value = allAnimals.where((animal) => animal.staffId == null).toList();
    }
  }

  void initiateSpot(int id) async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      await animalRepo.initiateSpot(id: id);
      int index = animalList.indexWhere((animal) => animal.id == id);
      if (index != -1) {
        animalList[index] = Animal.copyWith(animalList[index], isSpotInitiated: true);
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error initiating spot: $e')));
    }
  }

  void getAnimals() async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      isLoading.value = true;
      final data = await animalRepo.getAnimals(page: page.value);
      if (page.value == 1) {
        allAnimals.value = (data['animals'] as List).map((e) => Animal.fromJson(e)).toList();
      } else {
        allAnimals.addAll((data['animals'] as List).map((e) => Animal.fromJson(e)).toList());
      }
      _toggleAnimals(selectedAnimalFilter.value);
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error fetching animals: $e')));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAnimals();
    selectedAnimalFilter.listen(_toggleAnimals);
  }
}

sealed class AnimalFilterType {
  static const String all = 'All';
  static const String assigned = 'Assigned';
  static const String unassigned = 'Unassigned';
}
