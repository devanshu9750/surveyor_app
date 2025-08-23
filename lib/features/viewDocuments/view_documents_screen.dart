import 'package:flutter/material.dart';
import 'package:surveyor_app/models/animal.dart';

class ViewDocumentsScreen extends StatelessWidget {
  const ViewDocumentsScreen({super.key, required this.inspectionImages});
  static const String routeName = '/doc-view';

  final List<InspectionImage> inspectionImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      body: GridView.builder(
        itemCount: inspectionImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          final image = inspectionImages[index];
          return GestureDetector(
            onTap: () {
              // Handle image tap
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
    );
  }
}
