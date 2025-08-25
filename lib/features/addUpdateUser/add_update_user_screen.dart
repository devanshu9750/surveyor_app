import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_constants.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/addUpdateUser/add_update_user_controller.dart';

class AddUpdateUserScreen extends StatelessWidget {
  const AddUpdateUserScreen({super.key});
  static const String routeName = '/add-user';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateUserController>(
      init: AddUpdateUserController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: controller.user.value.id != null ? const Text('Update User') : const Text('Add User')),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.name,
                            decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.phone,
                            decoration: const InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder()),
                            keyboardType: TextInputType.phone,
                            validator: (value) => value?.isNumericOnly == true && value?.length == 10 ? null : 'Invalid phone number',
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.email,
                            decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => value?.isEmail == true ? null : 'Invalid email',
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            controller: controller.password,
                            decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                            obscureText: true,
                          ),
                          SizedBox(height: 2.h),
                          DropdownButtonFormField<int>(
                            value: controller.userType.value,
                            decoration: const InputDecoration(labelText: 'User Type', border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(value: AppConstants.staffUserTypeID, child: Text(AppConstants.staffUserTypeName)),
                              DropdownMenuItem(value: AppConstants.tpaUserTypeID, child: Text(AppConstants.tpaUserTypeName)),
                            ],
                            onChanged: (value) => controller.userType.value = value ?? 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => FilledButton(
                        onPressed: controller.enableAddUpdateButton.value ? controller.addUpdateUser : null,
                        child: controller.user.value.id != null ? const Text('Update') : const Text('Add'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
