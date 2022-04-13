import 'package:filepanel/presentation/permissions_screen/permissions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'localization/languages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends GetMaterialApp {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(), // your translations
      locale: const Locale('ru', 'RU'), // translations will be displayed in that locale
      fallbackLocale: const Locale('en', 'UK'),
      title: 'FilePanel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PermissionsScreen(),
    );
  }
}
