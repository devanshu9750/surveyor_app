import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyor_app/core/app_enums.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/features/animalDetail/widgets/document_picking_option_widget.dart';
import 'package:surveyor_app/features/home/widgets/staff_animal_list/staff_animal_list_controller.dart';
import 'package:surveyor_app/models/animal.dart';
import 'package:surveyor_app/repo/animal_repo.dart';
import 'package:surveyor_app/utils/camera_util.dart';
import 'package:surveyor_app/utils/pdf_util.dart';

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
          captureAndUploadImage(isSpotImage: true);
          break;
        case DocumentPickingOption.pdf:
          pickAndUploadPDF();
          break;
      }
    }
  }

  void pickAndUploadPDF() async {
    final pdfPath = await PdfUtil.pickPdfFile();

    if (pdfPath != null && animal.value.id != null) {
      try {
        showUploadingIndicator();
        AnimalRepo animalRepo = AnimalRepo();
        final data = await animalRepo.uploadSpotPDF(id: animal.value.id!, pdf: XFile(pdfPath));
        animal.value.animalDocuments?.add(AnimalDocument.fromJson(data));
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('PDF uploaded successfully !!')));
      } catch (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error uploading PDF: $e')));
      } finally {
        if (_uploadingWidgetKey.currentContext != null) {
          Navigator.of(_uploadingWidgetKey.currentContext!).pop();
        }
      }
    }
  }

  void captureAndUploadImage({bool isSpotImage = false}) async {
    final image = await CameraUtil.captureImage();
    if (image != null && animal.value.id != null) {
      try {
        showUploadingIndicator();
        AnimalRepo animalRepo = AnimalRepo();
        if (isSpotImage) {
          final data = await animalRepo.uploadSpotImage(id: animal.value.id!, image: image);
          animal.value.spotImages?.add(SpotImage.fromJson(data));
        } else {
          final data = await animalRepo.uploadInspectionImage(id: animal.value.id!, image: image);
          animal.value.inspectionImages?.add(InspectionImage.fromJson(data));
        }
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
      animal.value = Animal.fromJson({
        ...data['animal'],
        "inspection_images": data['inspection_images'],
        "animal_documents": data['animal_documents'],
      });
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error fetching animal details: $e')));
    }
  }

  Future<bool?> showSpotConfirmationDialogue() async {
    return await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Completion'),
          content: const Text('Are you sure you want to complete the spot for this animal? '),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('Confirm')),
          ],
        );
      },
    );
  }

  void completeSpotForAnimal() async {
    var result = await showSpotConfirmationDialogue();

    if (result == true) {
      AnimalRepo animalRepo = AnimalRepo();

      try {
        await animalRepo.completeSpotForAnimal(id: animal.value.id!);
        getAnimalDetails();
        if (Get.isRegistered<StaffAnimalListController>()) Get.find<StaffAnimalListController>().getAnimals();
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Spot completed successfully !!')));
      } catch (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error completing spot: $e')));
      }
    }
  }

  void markAsProcessed() async {
    AnimalRepo animalRepo = AnimalRepo();

    try {
      await animalRepo.animalClaimMarkAsProcessedFromTpa(id: animal.value.id!);
      getAnimalDetails();
      if (Get.isRegistered<StaffAnimalListController>()) Get.find<StaffAnimalListController>().getAnimals();
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Animal marked as processed successfully !!')));
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text('Error marking animal as processed: $e')));
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
