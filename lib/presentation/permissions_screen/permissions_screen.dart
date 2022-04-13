import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller.dart';

class PermissionsScreen extends GetView {
  final permissionsController = Get.put(PermissionsScreenController());
  PermissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Text('permissions_rationale'.tr)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('media_permission'.tr),
                Icon(
                  Icons.check,
                  color: permissionsController.mediaLibraryPermission.value.isGranted
                      ? Colors.green
                      : Colors.red,
                  size: 24.0,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('media_permission'.tr),
                Icon(
                  Icons.check,
                  color: permissionsController.mediaLibraryPermission.value.isGranted
                      ? Colors.green
                      : Colors.red,
                  size: 24.0,
                ),
              ],
            ),
            TextButton(
                onPressed: () => permissionsController.requestPermissions(),
                child: Text('request_permissions'.tr)),
          ],
        ),
      ),
    ));
  }
}
