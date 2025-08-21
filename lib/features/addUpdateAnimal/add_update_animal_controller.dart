import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/features/home/widgets/animals_list/animal_list_controller.dart';
import 'package:surveyor_app/features/home/widgets/users_list/users_list_controller.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/models/user.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class AddUpdateAnimalController extends GetxController {
  final arguments = Get.arguments;
  final tagNumber = TextEditingController();
  final ownerName = TextEditingController();
  final village = TextEditingController();
  final taluka = TextEditingController();
  final pincode = TextEditingController();
  final sumInsured = TextEditingController();
  final policyDate = TextEditingController();
  final enableAddUpdateButton = false.obs;
  final animal = Animal().obs;
  final staffID = (-1).obs;
  final staffList = <User>[].obs;

  void addUpdateAnimal() async {
    if (animal.value.id == null) {
      animal.value = Animal(
        tagNumber: tagNumber.text,
        ownerName: ownerName.text,
        village: village.text,
        taluka: taluka.text,
        pincode: pincode.text,
        sumInsured: int.tryParse(sumInsured.text),
        policyDate: DateTime.tryParse(policyDate.text),
      );
    } else {
      animal.value = Animal.copyWith(
        animal.value,
        tagNumber: tagNumber.text,
        ownerName: ownerName.text,
        village: village.text,
        taluka: taluka.text,
        pincode: pincode.text,
        sumInsured: int.tryParse(sumInsured.text),
        policyDate: DateTime.tryParse(policyDate.text),
      );
    }

    try {
      AnimalRepo animalRepo = AnimalRepo();
      await animalRepo.addOrUpdateAnimal({...animal.value.toJson(), if (staffID.value != -1) 'staff_id': staffID.value});
      if (Get.isRegistered<AnimalListController>()) {
        Get.find<AnimalListController>()
          ..page.value = 1
          ..getAnimals();
      }
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Failed to save animal data')));
    }
  }

  void _updateAddUpdateButtonState() {
    enableAddUpdateButton.value =
        tagNumber.text.isNotEmpty &&
        ownerName.text.isNotEmpty &&
        village.text.isNotEmpty &&
        taluka.text.isNotEmpty &&
        pincode.text.isNumericOnly &&
        sumInsured.text.isNum &&
        policyDate.text.isNotEmpty;
  }

  void pickPolicyDate() async {
    FocusScope.of(Get.context!).unfocus();
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2010),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    if (picked != null) {
      policyDate.text = picked.toLocal().toString().split(' ')[0];
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (arguments != null && arguments is Animal) {
      animal.value = arguments as Animal;
      tagNumber.text = animal.value.tagNumber ?? '';
      ownerName.text = animal.value.ownerName ?? '';
      village.text = animal.value.village ?? '';
      taluka.text = animal.value.taluka ?? '';
      pincode.text = animal.value.pincode ?? '';
      sumInsured.text = animal.value.sumInsured?.toString() ?? '';
      policyDate.text = animal.value.policyDate?.toLocal().toString().split(' ')[0] ?? '';
      staffID.value = animal.value.staffId ?? -1;
      _updateAddUpdateButtonState();
    }
    tagNumber.addListener(_updateAddUpdateButtonState);
    ownerName.addListener(_updateAddUpdateButtonState);
    village.addListener(_updateAddUpdateButtonState);
    taluka.addListener(_updateAddUpdateButtonState);
    pincode.addListener(_updateAddUpdateButtonState);
    sumInsured.addListener(_updateAddUpdateButtonState);
    policyDate.addListener(_updateAddUpdateButtonState);
    if (Get.isRegistered<UsersListController>()) {
      staffList.value = Get.find<UsersListController>().userList.where((user) => user.userType == AppConstants.staffUserTypeID).toList();
    }
  }

  @override
  void onClose() {
    tagNumber.dispose();
    ownerName.dispose();
    village.dispose();
    taluka.dispose();
    pincode.dispose();
    sumInsured.dispose();
    policyDate.dispose();
    super.onClose();
  }
}
