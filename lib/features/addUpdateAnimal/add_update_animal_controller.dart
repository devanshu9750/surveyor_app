import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';

class AddUpdateAnimalController extends GetxController {
  final tagNumber = TextEditingController();
  final ownerName = TextEditingController();
  final village = TextEditingController();
  final taluka = TextEditingController();
  final pincode = TextEditingController();
  final sumInsured = TextEditingController();
  final policyDate = TextEditingController();
  final enableAddUpdateButton = false.obs;
  final animal = Animal().obs;

  void addUpdateAnimal() async {
    animal.value = Animal(
      tagNumber: tagNumber.text,
      ownerName: ownerName.text,
      village: village.text,
      taluka: taluka.text,
      pincode: pincode.text,
      sumInsured: int.tryParse(sumInsured.text),
      policyDate: DateTime.tryParse(policyDate.text),
    );

    try {
      AnimalRepo animalRepo = AnimalRepo();
      await animalRepo.addOrUpdateAnimal(animal.value.toJson());
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
    tagNumber.addListener(_updateAddUpdateButtonState);
    ownerName.addListener(_updateAddUpdateButtonState);
    village.addListener(_updateAddUpdateButtonState);
    taluka.addListener(_updateAddUpdateButtonState);
    pincode.addListener(_updateAddUpdateButtonState);
    sumInsured.addListener(_updateAddUpdateButtonState);
    policyDate.addListener(_updateAddUpdateButtonState);
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
