// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';

class CustomVideoControllers extends StatelessWidget {
  const CustomVideoControllers({
    Key? key,
    // required this.controller,
    required this.homeController,
  }) : super(key: key);

  // final VideoPlayerController controller;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // print(homeController.state.isPlaying.value);
        return Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              reverseDuration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              // child: homeController.videoPlayerController.value.isPlaying
              child: homeController.state.isPlaying.value
                  // ? Container(
                  //     color: Colors.black26,
                  //     child: const Center(
                  //       child: Icon(
                  //         Icons.pause,
                  //         color: Colors.white,
                  //         size: 52.0,
                  //         semanticLabel: 'Play',
                  //       ),
                  //     ),
                  //   )
                  ? const SizedBox.shrink()
                  : Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 52.0,
                          semanticLabel: 'Play',
                        ),
                      ),
                    ),
            ),
            InkWell(
              onTap: () {
                homeController.videoPlayerController.value.isPlaying
                    ? homeController.videoPlayerController.pause()
                    : homeController.videoPlayerController.play();

                // Set value after play or pause
                homeController.state.isPlaying.value =
                    homeController.videoPlayerController.value.isPlaying;
              },
            ),
          ],
        );
      },
    );
  }
}
