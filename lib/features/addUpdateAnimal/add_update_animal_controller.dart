import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateAnimalController extends GetxController {
  final tagNumber = TextEditingController();
  final ownerName = TextEditingController();
  final village = TextEditingController();
  final taluka = TextEditingController();
  final pincode = TextEditingController();
  final sumInsured = TextEditingController();
  final policyDate = TextEditingController();
  final enableAddUpdateButton = false.obs;

  void addUpdateAnimal() {}

  void _updateAddUpdateButtonState() {
    enableAddUpdateButton.value =
        tagNumber.text.isNotEmpty &&
        ownerName.text.isNotEmpty &&
        village.text.isNotEmpty &&
        taluka.text.isNotEmpty &&
        pincode.text.isNotEmpty &&
        sumInsured.text.isNotEmpty &&
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
}
