import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lilac_flutter_machine_test/routes/pages.dart';
import 'package:lilac_flutter_machine_test/routes/route_names.dart';

import 'presentation/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // Routes
      initialRoute: AppRouteNames.initial,
      getPages: AppPages.getPages,
    );
  }
}
