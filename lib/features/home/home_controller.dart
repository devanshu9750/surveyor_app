import 'package:get/state_manager.dart';
import 'package:surveyor_app/db/app_get_storage.dart';
import 'package:surveyor_app/models/user.dart';

class HomeController extends GetxController {
  final bottomBarIndex = 0.obs;
  final user = (User() as User?).obs;

  @override
  void onInit() {
    super.onInit();
    user.value = User.fromJson(AppGetStorage().read('user') ?? {});
  }
}
