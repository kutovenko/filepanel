import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

const Color activeColor = Colors.white;

class HomeScreen extends GetView {
  final fileController = Get.put(FileManagerController());
  final panelController = Get.put(PanelController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Creates a widget that registers a callback to veto attempts by the user to dismiss the enclosing
    // or controllers the system's back button
    return WillPopScope(
      onWillPop: () async {
        if (await fileController.isRootDirectory()) {
          return true;
        } else {
          fileController.goToParentDirectory();
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
                  Expanded(
                    child: Stack(
                      children: [
                        FileManager(
                          controller: fileController,
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
                                    title: Text(FileManager.basename(entity)),
                                    subtitle: subtitle(entity),
                                    onLongPress: () async {},
                                    onTap: () async {
                                      if (FileManager.isDirectory(entity)) {
                                        // open the folder
                                        fileController.openDirectory(entity);

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
                            child: NormalAppBar(panelController)),

                        // NormalAppBar(panelController),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 4.0,
                  ),
                  Expanded(
                    child: FileManager(
                      controller: fileController,
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
                                title: Text(FileManager.basename(entity)),
                                subtitle: subtitle(entity),
                                onLongPress: () async {},
                                onTap: () async {
                                  if (FileManager.isDirectory(entity)) {
                                    // open the folder
                                    fileController.openDirectory(entity);

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
                  ),
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

class NormalAppBar extends StatelessWidget {
  final PanelController controller;
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

class FolderAppBar extends StatelessWidget {
  const FolderAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FileAppBar extends StatelessWidget {
  const FileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
