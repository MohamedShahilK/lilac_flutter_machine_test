// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/state.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  final state = HomeState();

  late VideoPlayerController videoPlayerController;

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onReady() {
    super.onReady();

    //
    state.isPlaying.value = videoPlayerController.value.isPlaying;

    //
    videoPlayerController.addListener(() {
      // print(videoPlayerController.value.position.inSeconds);R

      // add postion value into "Rx<Duration> postion"
      state.position.value = videoPlayerController.value.position;
    });
  }

  @override
  void onInit() {
    super.onInit();
    videoPlayerController = VideoPlayerController.network(
      // formatHint: VideoFormat.other,
      // httpHeaders: ,
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'
          // 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
          .replaceFirst('http', 'https'),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        // setState(() {});
        print("isIntialized : ${videoPlayerController.value.isInitialized}");

        state.isInitialized.value = true;

        // add duration value into "Rx<Duration> duration"
        state.duration.value = videoPlayerController.value.duration;
      });
    videoPlayerController.pause();
    // setLandscape();
  }

  // Future setLandscape() async {
  //   await SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);
  // }

  // LogOut
  Future performLogOut() async {
    final User? userData = FirebaseAuth.instance.currentUser;
    if (userData != null) {
      await FirebaseAuth.instance.signOut();
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
}
