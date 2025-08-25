import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/animalDetail/animal_detail_controller.dart';
import 'package:surveyor_app/features/home/home_controller.dart';
import 'package:surveyor_app/features/viewDocuments/view_documents_screen.dart';

class AnimalDetailScreen extends StatelessWidget {
  const AnimalDetailScreen({super.key});
  static const String routeName = '/animal-detail';

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AnimalDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Animal Details')),
          body: Column(
            children: [
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Tag Number', controller.animal.value.tagNumber),
                        _buildDetailRow('Owner Name', controller.animal.value.ownerName),
                        _buildDetailRow('Village', controller.animal.value.village),
                        _buildDetailRow('Taluka', controller.animal.value.taluka),
                        _buildDetailRow('Pincode', controller.animal.value.pincode),
                        _buildDetailRow('Sum Insured', controller.animal.value.sumInsured.toString()),
                        _buildDetailRow('Policy Date', controller.animal.value.policyDate.toString().split(' ')[0]),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.animal.value.inspectionImages?.isNotEmpty ?? false
                    ? Card(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        child: ListTile(
                          onTap: () =>
                              Get.toNamed(ViewDocumentsScreen.routeName, arguments: {"inspectionImages": controller.animal.value.inspectionImages}),
                          title: const Text("Inspection Images", style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Icon(Icons.adaptive.arrow_forward_rounded),
                        ),
                      )
                    : const SizedBox(),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => controller.animal.value.animalDocuments?.isNotEmpty ?? false
                    ? Card(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        child: ListTile(
                          onTap: () =>
                              Get.toNamed(ViewDocumentsScreen.routeName, arguments: {"animalDocuments": controller.animal.value.animalDocuments}),
                          title: const Text("Animal Documents", style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Icon(Icons.adaptive.arrow_forward_rounded),
                        ),
                      )
                    : const SizedBox(),
              ),
              const Spacer(),
              if (Get.find<HomeController>().isTPA)
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 2.h),
                  child: SizedBox(
                    width: 90.w,
                    child: FilledButton(onPressed: null, child: const Text('Mark as processed')),
                  ),
                )
              else
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 2.h),
                  child: SizedBox(
                    width: 90.w,
                    child: FilledButton(onPressed: controller.showDocumentPickingOptions, child: const Text('Add Inspection Image/Document')),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 35.w,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
            ),
          ),
          Expanded(
            child: Text(value ?? '', style: const TextStyle(fontSize: 16, color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
