import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/addUpdateAnimal/add_update_animal_controller.dart';

class AddUpdateAnimalScreen extends StatelessWidget {
  const AddUpdateAnimalScreen({super.key});
  static const String routeName = '/add-update-animal';

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddUpdateAnimalController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Add/Update Animal'), elevation: 10),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: controller.tagNumber,
                            decoration: const InputDecoration(labelText: 'Tag Number', border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.ownerName,
                            decoration: const InputDecoration(labelText: 'Owner Name', border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.village,
                            decoration: const InputDecoration(labelText: 'Village', border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.taluka,
                            decoration: const InputDecoration(labelText: 'Taluka', border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.pincode,
                            decoration: const InputDecoration(labelText: 'Pincode', border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.sumInsured,
                            decoration: const InputDecoration(labelText: 'Sum Insured', border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          SizedBox(height: 2.h),
                          GestureDetector(
                            onTap: controller.pickPolicyDate,
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: controller.policyDate,
                                decoration: const InputDecoration(
                                  labelText: 'Policy Date',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                readOnly: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 90.w,
                  child: Obx(
                    () => FilledButton(
                      onPressed: controller.enableAddUpdateButton.value ? controller.addUpdateAnimal : null,
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
