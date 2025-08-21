import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class AnimalListController extends GetxController {
  final page = 1.obs;
  final isLoading = true.obs;
  final animalList = <Animal>[].obs;

  void getAnimals() async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      isLoading.value = true;
      final data = await animalRepo.getAnimals(page: page.value);
      if (page.value == 1) {
        animalList.value = (data['animals'] as List).map((e) => Animal.fromJson(e)).toList();
      } else {
        animalList.addAll((data['animals'] as List).map((e) => Animal.fromJson(e)).toList());
      }
    } catch (e) {
      animalList.clear();
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error fetching animals: $e')));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAnimals();
  }
}
