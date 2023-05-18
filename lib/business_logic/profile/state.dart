import 'package:get/get.dart';

class ProfileState {
  RxBool isProfilePage = true.obs;
  RxString userName = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phNum = ''.obs;
  // RxString dob = ''.obs;
  Rx<DateTime> dob = DateTime.now().obs;
  
}

