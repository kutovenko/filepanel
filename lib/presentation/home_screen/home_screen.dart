import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import 'controller.dart';

const Color activeColor = Colors.white;

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FileManagerController(), tag: LEFT_PANEL_TAG);
    Get.put(FileManagerController(), tag: RIGHT_PANEL_TAG);
    Get.put(HomePageController());
  }
}


class HomeScreen extends GetView {
final HomePageController homePageController = Get.find();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var activeController = homePageController.activePanel.value == ActivePanel.left ? homePageController.leftPanelFileController : homePageController.rightPanelFileController;
    return WillPopScope(
      onWillPop: () async {
        if (await activeController.value.isRootDirectory()) {
          return true;
        } else {
          activeController.value.goToParentDirectory();
          return false;
        }
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: activeColor,
            // bottomNavigationBar: NormalAppBar(PanelController()),
            body: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainFilePanel(homePageController.leftPanelFileController.value),
                  const VerticalDivider(
                    thickness: 4.0,
                  ),
                  MainFilePanel(homePageController.rightPanelFileController.value),
                ],
              ),
            )),
      ),
    );
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data!.size;

            return Text(
              FileManager.formatBytes(size),
            );
          }
          return Text(
            "${snapshot.data!.modified}",
          );
        } else {
          return const Text("");
        }
      },
    );
  }
}

class MainFilePanel extends StatelessWidget {
  final FileManagerController _fileController;
  const MainFilePanel(this._fileController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          FileManager(
            controller: _fileController,
            builder: (context, snapshot) {
              final List<FileSystemEntity> entities = snapshot;
              return ListView.builder(
                itemCount: entities.length,
                itemBuilder: (context, index) {
                  FileSystemEntity entity = entities[index];
                  return Card(
                    child: ListTile(
                      leading: FileManager.isFile(entity)
                          ? const Icon(Icons.feed_outlined)
                          : const Icon(Icons.folder),
                      title: AutoSizeText(FileManager.basename(entity), maxLines: 1,),
                      subtitle: MainPanelSubtitle(entity),
                      onLongPress: () async {},
                      onTap: () async {
                        if (FileManager.isDirectory(entity)) {
                          // open the folder
                          _fileController.openDirectory(entity);

                          // delete a folder
                          // await entity.delete(recursive: true);

                          // rename a folder
                          // await entity.rename("newPath");

                          // Check weather folder exists
                          // entity.exists();

                          // get date of file
                          // DateTime date = (await entity.stat()).modified;
                        } else {
                          // delete a file
                          // await entity.delete();

                          // rename a file
                          // await entity.rename("newPath");

                          // Check weather file exists
                          // entity.exists();

                          // get date of file
                          // DateTime date = (await entity.stat()).modified;

                          // get the size of the file
                          // int size = (await entity.stat()).size;
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child:  Container(
                color: activeColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () async {
                        await _fileController.goToParentDirectory();
                      },
                    ),
                    const Spacer(),
                    // IconButton(
                    //   onPressed: () => _panelController.createFolder(context),
                    //   icon: const Icon(Icons.create_new_folder_outlined),
                    // ),
                    // IconButton(
                    //   onPressed: () => _panelController.sort(context),
                    //   icon: const Icon(Icons.sort_rounded),
                    // ),
                  ],
                ),
              ),


          ),],
      ),
    );
  }
}

class MainPanelSubtitle extends StatelessWidget {
  final FileSystemEntity _entity;
  const MainPanelSubtitle(this._entity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FileStat>(
      future: _entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_entity is File) {
            int size = snapshot.data!.size;

            return Text(
              FileManager.formatBytes(size),
            );
          }
          return Text(
            "${snapshot.data!.modified}",
          );
        } else {
          return const Text("");
        }
      },
    );
  }
}



class NormalAppBar extends StatelessWidget {
  final HomePageController controller;
  const NormalAppBar(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: activeColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              await controller.goToParentDirectory();
            },
          ),
          const Spacer(),
          IconButton(
            onPressed: () => controller.createFolder(context),
            icon: const Icon(Icons.create_new_folder_outlined),
          ),
          IconButton(
            onPressed: () => controller.sort(context),
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
    );
  }
}
