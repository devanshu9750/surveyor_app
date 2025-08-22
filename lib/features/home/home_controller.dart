import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/db/app_get_storage.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class HomeController extends GetxController {
  final bottomBarIndex = 0.obs;
  final user = (User() as User?).obs;
  final searchedAnimals = <Animal>[].obs;
  final searchController = SearchController();
  Timer? debouncer;

  bool get isAdmin => user.value?.userType == AppConstants.adminUserTypeID;

  void searchedAnimalTap(Animal animal) {
    Get
      ..back()
      ..toNamed('/add-update-animal', arguments: animal);
    searchController.clear();
    searchedAnimals.clear();
  }

  void _searchDebouncer() {
    if (searchController.text.isEmpty) {
      searchedAnimals.clear();
      return;
    }

    debouncer?.cancel();
    debouncer = Timer(1.seconds, () async {
      AnimalRepo animalRepo = AnimalRepo();
      try {
        Map data = await animalRepo.getAnimals(searchQuery: searchController.text);
        if (data['animals'] != null) {
          searchedAnimals.value = (data['animals'] as List).map((animal) => Animal.fromJson(animal)).toList();
        }
      } catch (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("Searching failed...")));
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    user.value = User.fromJson(AppGetStorage().read('user') ?? {});
    searchController.addListener(_searchDebouncer);
  }

  @override
  void onClose() {
    debouncer?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
