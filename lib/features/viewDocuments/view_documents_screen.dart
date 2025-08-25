import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyor_app/core/app_extensions.dart';
import 'package:surveyor_app/models/animal.dart';

class ViewDocumentsScreen extends StatelessWidget {
  const ViewDocumentsScreen({super.key, this.inspectionImages = const [], this.animalDocuments = const []});
  static const String routeName = '/doc-view';

  final List<InspectionImage> inspectionImages;
  final List<AnimalDocument> animalDocuments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 2.w),
        child: GridView.builder(
          itemCount: inspectionImages.isEmpty ? animalDocuments.length : inspectionImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: inspectionImages.isEmpty
              ? (context, index) {
                  final document = animalDocuments[index];
                  return GestureDetector(
                    onTap: () {
                      // Handle PDF tap
                    },
                    child: GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.1.w),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black54,
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  document.name,
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              : (context, index) {
                  final image = inspectionImages[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(image.url, fit: BoxFit.cover),
                              Positioned(
                                left: 4.w,
                                top: 2.h,
                                child: GestureDetector(
                                  onTap: Get.back,
                                  child: Container(
                                    padding: EdgeInsets.all(1.w),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
                                    child: Icon(Icons.close, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: GridTile(
                      child: Image.network(
                        image.url,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  );
                },
        ),
      ),
    );
  }
}
