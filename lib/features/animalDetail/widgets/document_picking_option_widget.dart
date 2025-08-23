import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_enums.dart';
import 'package:surveyor_app/core/app_extensions.dart';

class DocumentPickingOptionWidget extends StatelessWidget {
  const DocumentPickingOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 2.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Take a photo'),
            onTap: () {
              Get.back(result: DocumentPickingOption.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Upload a PDF'),
            onTap: () {
              Get.back(result: DocumentPickingOption.pdf);
            },
          ),
        ],
      ),
    );
  }
}
