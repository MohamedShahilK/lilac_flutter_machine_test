// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/state.dart';
import 'package:lilac_flutter_machine_test/utils/data/video_urls.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  final state = HomeState();

   VideoPlayerController videoPlayerController = VideoPlayerController.network('');

  ValueNotifier<Future<void>?> videoFuture = ValueNotifier(null);

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
   videoFuture.value  = play(videos[0]['url']!);
  }

  @override
  void onReady() {
    super.onReady();

    //
    state.isPlaying.value = videoPlayerController.value.isPlaying;

    //
    videoPlayerController.addListener(() {
    print('1111111111111111111');
      // print(videoPlayerController.value.position.inSeconds);R

      // add postion value into "Rx<Duration> postion"
      state.position.value = videoPlayerController.value.position;
    });
  }



  Future<void> play(String url) async {
    // if (url.isEmpty) {
    //   url =
    //       'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4';
    // }
    if (videoPlayerController.value.isInitialized) {
      await videoPlayerController.dispose();
    }
    videoPlayerController = VideoPlayerController.network(url);
    return videoPlayerController.initialize().then((value) {
      // add duration value into "Rx<Duration> duration"
      state.duration.value = videoPlayerController.value.duration;
      state.position.value = videoPlayerController.value.position;
      onReady();
      print('index : ${state.videoIndex}');
      videoPlayerController.pause();
    });
  }

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
  Future<void> dispose() async {
    super.dispose();
    await videoPlayerController.dispose();
  }
}



  // @override
  // void onInit() {
  //   super.onInit();
     
  //   // getVideos();
  //   // videoPlayerController = VideoPlayerController.network(
  //   //   // formatHint: VideoFormat.other,
  //   //   // httpHeaders: ,
  //   //   'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'
  //   //       // 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
  //   //       .replaceFirst('http', 'https'),
  //   // )..initialize().then((_) {
  //   //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //   //     // setState(() {});
  //   //     print("isIntialized : ${videoPlayerController.value.isInitialized}");

  //   //     state.isInitialized.value = true;

  //   //     // add duration value into "Rx<Duration> duration"
  //   //     state.duration.value = videoPlayerController.value.duration;
  //   //   });
  //   // videoPlayerController.pause();
    
   
  // }