import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView {
  final fileController = Get.put(FileManagerController());

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
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => createFolder(context),
                icon: const Icon(Icons.create_new_folder_outlined),
              ),
              IconButton(
                onPressed: () => sort(context),
                icon: const Icon(Icons.sort_rounded),
              ),
              IconButton(
                onPressed: () => selectStorage(context),
                icon: const Icon(Icons.sd_storage_rounded),
              )
            ],
            // title: ValueListenableBuilder<String>(
            //   valueListenable: fileController.titleNotifier,
            //   builder: (context, title, _) => Text(title),
            // ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                await fileController.goToParentDirectory();
              },
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(10),
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
          )),
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

  selectStorage(BuildContext context) {
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
                                fileController.openDirectory(e);
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

  sort(BuildContext context) async {
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
                    fileController.sortedBy = SortBy.name;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Size"),
                  onTap: () {
                    fileController.sortedBy = SortBy.size;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("Date"),
                  onTap: () {
                    fileController.sortedBy = SortBy.date;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text("type"),
                  onTap: () {
                    fileController.sortedBy = SortBy.type;
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  createFolder(BuildContext context) async {
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
                      await FileManager.createFolder(
                          fileController.getCurrentPath, folderName.text);
                      // Open Created Folder
                      fileController.setCurrentPath =
                          fileController.getCurrentPath + "/" + folderName.text;
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
