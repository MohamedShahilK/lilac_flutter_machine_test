import 'package:flutter/material.dart';
import 'package:lilac_flutter_machine_test/services/storage_service.dart';

// in order to access changenotifier, need to install provider

class MyThemeStateNotifier extends ChangeNotifier {
  //
  // bool isDarkModeOn = false;
  bool isDarkModeOn = StorageService.to.getBool("saveThemeMode");

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
    StorageService.to.setBool("saveThemeMode", this.isDarkModeOn);
  }
}
