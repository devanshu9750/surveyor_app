import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class AnimalDetailController extends GetxController {
  final arguments = Get.arguments;
  final animal = Animal().obs;

  void getAnimalDetails() async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      final data = await animalRepo.getAnimalById(id: arguments);
      animal.value = Animal.fromJson(data['animal']);
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error fetching animal details: $e')));
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (arguments != null && arguments is int) {
      getAnimalDetails();
    } else {
      Get.back();
    }
  }
}
