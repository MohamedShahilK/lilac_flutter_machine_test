import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lilac_flutter_machine_test/routes/pages.dart';
import 'package:lilac_flutter_machine_test/routes/route_names.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.leanBack,
  //   overlays: SystemUiOverlay.values,
  // );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  // print(FirebaseAuth.instance.currentUser == null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lilac Flutter Machine Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100]),

      // Routes
      initialRoute: AppRouteNames.initial,
      getPages: AppPages.getPages,
    );
  }
}
