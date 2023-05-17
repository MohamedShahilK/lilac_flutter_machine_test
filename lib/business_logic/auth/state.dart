import 'package:get/get.dart';

class AuthState {
  RxBool isOtpPage = false.obs;

  RxString verificationId = ''.obs;
  RxString phoneOtp = ''.obs;
}
