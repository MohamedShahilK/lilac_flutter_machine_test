import 'package:get/get.dart';

class AuthState {
  RxBool isOtpPage = false.obs;

  RxString verificationId = ''.obs;
  RxInt forceResendingToken = 0.obs;
  
  // RxBool restartTimer = false.obs;

  RxString phoneOtp = ''.obs;
}
