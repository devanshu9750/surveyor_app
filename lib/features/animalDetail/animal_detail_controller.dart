import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_enums.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/animalDetail/widgets/document_picking_option_widget.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';
import 'package:surveyor_app/utils/camera_util.dart';

class AnimalDetailController extends GetxController {
  final arguments = Get.arguments;
  final animal = Animal().obs;
  final _uploadingWidgetKey = GlobalKey();

  void showDocumentPickingOptions() async {
    final result = await showModalBottomSheet<DocumentPickingOption?>(
      context: Get.context!,
      builder: (context) {
        return const DocumentPickingOptionWidget();
      },
    );
    if (result != null) {
      switch (result) {
        case DocumentPickingOption.camera:
          captureAndUploadImage();
          break;
        default:
          break;
      }
    }
  }

  void captureAndUploadImage() async {
    final image = await CameraUtil.captureImage();
    if (image != null && animal.value.id != null) {
      try {
        showUploadingIndicator();
        AnimalRepo animalRepo = AnimalRepo();
        final data = await animalRepo.uploadInspectionImage(id: animal.value.id!, image: image);
        animal.value.inspectionImages?.add(InspectionImage.fromJson(data));
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Image uploaded successfully !!')));
      } catch (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
      } finally {
        if (_uploadingWidgetKey.currentContext != null) {
          Navigator.of(_uploadingWidgetKey.currentContext!).pop();
        }
      }
    }
  }

  void showUploadingIndicator() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          key: _uploadingWidgetKey,
          content: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(child: CircularProgressIndicator()),
                SizedBox(width: 5.w),
                Text('Uploading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void getAnimalDetails() async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      final data = await animalRepo.getAnimalById(id: arguments);
      animal.value = Animal.fromJson({...data['animal'], "inspection_images": data['inspection_images']});
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error fetching animal details: $e')));
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (arguments != null && arguments is int) {
      getAnimalDetails();
    } else {
      Get.back();
    }
  }
}
