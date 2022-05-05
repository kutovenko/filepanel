import 'package:filepanel/presentation/home_screen/home_screen.dart';
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
      initialBinding: HomeBinding(),
      translations: Languages(),
      locale: const Locale('ru', 'RU'),
      fallbackLocale: const Locale('en', 'UK'),
      title: 'FilePanel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PermissionsScreen(),
    );
  }
}
