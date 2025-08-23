import 'package:get/get.dart';
import 'package:surveyor_app/features/home/home_controller.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class StaffAnimalListController extends GetxController {
  final isLoading = true.obs;
  final animalList = <Animal>[].obs;

  void getAnimals() async {
    AnimalRepo animalRepo = AnimalRepo();
    try {
      isLoading.value = true;
      final data = await animalRepo.getAnimals(staffID: Get.find<HomeController>().user.value?.id);
      animalList.value = (data['animals'] as List).map((e) => Animal.fromJson(e)).toList();
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
  }
}
