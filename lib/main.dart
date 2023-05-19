import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/routes/pages.dart';
import 'package:lilac_flutter_machine_test/routes/route_names.dart';
import 'package:lilac_flutter_machine_test/services/storage_service.dart';
import 'package:lilac_flutter_machine_test/theme/app_state_notifier.dart';
import 'package:lilac_flutter_machine_test/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //enables secure mode for app, disables screenshot, screen recording
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  //enables secure mode for app, disables screenshot, screen recording
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync<StorageService>(() => StorageService().init());

  // awesome notification initialization
  AwesomeNotifications().initialize(
    null, // icon for app when notification hits
    [
      NotificationChannel(
        channelKey: 'key1',
        channelName: 'Sha Coder Dev',
        channelDescription: 'Notification',
        defaultColor: const Color(0xFF9050DD),
        ledColor: Colors.white,
        playSound: true,
        // soundSource: 'soundUrl',
        enableLights: true,
        enableVibration: true,
      )
    ],
  );

  //
  runApp(
    ChangeNotifierProvider<MyThemeStateNotifier>(
      create: (context) => MyThemeStateNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeStateNotifier>(
      builder: (context, appState, child) {
        return GetMaterialApp(
          title: 'Lilac Flutter Machine Test',
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   scaffoldBackgroundColor: Colors.grey[100],
          // ),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,

          initialRoute: AppRouteNames.initial,
          getPages: AppPages.getPages,
        );
      },
    );
  }
}
