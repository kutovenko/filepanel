import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../home_screen/home_screen.dart';

class PermissionsScreenController extends GetxController {
  var storagePermission = PermissionStatus.denied.obs;
  var mediaLibraryPermission = PermissionStatus.denied.obs;

  Future<void> requestPermissions() async {
    await [Permission.storage, Permission.mediaLibrary].request();

    storagePermission.value = await Permission.storage.status;
    mediaLibraryPermission.value = await Permission.mediaLibrary.status;
    _checkAndRoute();
  }

  @override
  void onInit() async {
    storagePermission.value = await Permission.storage.status;
    mediaLibraryPermission.value = await Permission.mediaLibrary.status;
    _checkAndRoute();
    super.onInit();
  }

  void _checkAndRoute() {
    if (storagePermission.value.isGranted && mediaLibraryPermission.value.isGranted) {
      Get.to(HomeScreen());
    }
  }
}
