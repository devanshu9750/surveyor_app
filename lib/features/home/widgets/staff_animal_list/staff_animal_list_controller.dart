import 'package:get/get.dart';
import 'package:surveyor_app/features/home/home_controller.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class StaffAnimalListController extends GetxController {
  final isLoading = true.obs;
  final allAnimals = <Animal>[].obs;
  final animalList = <Animal>[].obs;
  final animalFilters = [AnimalFilterType.all, AnimalFilterType.spotInitiated, AnimalFilterType.spotCompleted];
  final selectedAnimalFilter = AnimalFilterType.all.obs;

  void toggleAnimalFilter(String animalFilter) => selectedAnimalFilter.value = animalFilter;

  void _toggleAnimals(String animalType) {
    if (animalType == AnimalFilterType.all) {
      animalList.value = allAnimals;
    } else if (animalType == AnimalFilterType.spotInitiated) {
      animalList.value = allAnimals.where((animal) => animal.isSpotInitiated == true && animal.isSpotCompleted == false).toList();
    } else {
      animalList.value = allAnimals.where((animal) => animal.isSpotCompleted == true).toList();
    }
  }

  void getAnimals() async {
    AnimalRepo animalRepo = AnimalRepo();
    try {
      isLoading.value = true;
      final data = await animalRepo.getAnimals(staffID: Get.find<HomeController>().user.value?.id);
      allAnimals.value = (data['animals'] as List).map((e) => Animal.fromJson(e)).toList();
      animalList.value = allAnimals;
      selectedAnimalFilter.value = AnimalFilterType.all;
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
  static const all = 'All';
  static const spotInitiated = 'Spot Initiated';
  static const spotCompleted = 'Spot Completed';
}
