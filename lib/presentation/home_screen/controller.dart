import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:filepanel/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ActivePanel{
  left,
  right
}

class HomePageController extends GetxController {
  //Panel Controllers
  final leftPanelFileController  = Get.put(FileManagerController(), tag: LEFT_PANEL_TAG).obs;
  final rightPanelFileController = Get.put(FileManagerController(), tag: RIGHT_PANEL_TAG).obs;

  //State variables
  String leftPanelActivePath = '.';
  String leftPaneActivePath = '.';
  var activePanel = ActivePanel.left.obs;

  //Dialog action controller


  Future<void> goToParentDirectory() async {
    activePanel == ActivePanel.left.obs ?
    await leftPanelFileController.value.goToParentDirectory() : await rightPanelFileController.value.goToParentDirectory();
  }

  void selectStorage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: FutureBuilder<List<Directory>>(
          future: FileManager.getStorageList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<FileSystemEntity> storageList = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: storageList
                        .map((e) => ListTile(
                              title: Text(
                                FileManager.basename(e),
                              ),
                              onTap: () {
                                activePanel == ActivePanel.left.obs ?
                                leftPanelFileController.value.openDirectory(e) : rightPanelFileController.value.openDirectory(e);
                                Navigator.pop(context);
                              },
                            ))
                        .toList()),
              );
            }
            return const Dialog(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void sort(BuildContext context) async {
    var fileController = activePanel == ActivePanel.left.obs ? leftPanelFileController : rightPanelFileController;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: const Text("Name"),
                  onTap: () {
                    fileController.value.sortedBy = SortBy.name;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Size"),
                  onTap: () {
                    fileController.value.sortedBy = SortBy.size;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Date"),
                  onTap: () {
                    fileController.value.sortedBy = SortBy.date;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("type"),
                  onTap: () {
                    fileController.value.sortedBy = SortBy.type;
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void createFolder(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController folderName = TextEditingController();
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: TextField(
                    controller: folderName,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Create Folder
                      var fileController = activePanel == ActivePanel.left.obs ? leftPanelFileController : rightPanelFileController;
                      await FileManager.createFolder(
                          fileController.value.getCurrentPath, folderName.text);
                      // Open Created Folder
                      fileController.value.setCurrentPath =
                          fileController.value.getCurrentPath + "/" + folderName.text;
                    } catch (e) {}

                    Navigator.pop(context);
                  },
                  child: const Text('Create Folder'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
