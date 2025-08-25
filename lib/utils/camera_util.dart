import 'package:image_picker/image_picker.dart';

class CameraUtil {
  static Future<XFile?> captureImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }
}
