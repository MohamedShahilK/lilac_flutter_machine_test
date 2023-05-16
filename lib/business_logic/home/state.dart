import 'package:get/get.dart';

class HomeState {
  RxBool isInitialized = false.obs;
  RxBool isPlaying = false.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  // RxBool isLandScape = false.obs;
  RxBool isVolumeMuted = false.obs;

}
