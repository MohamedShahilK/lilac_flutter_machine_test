// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
// import 'package:volume_controller/volume_controller.dart';

class CustomVideoControllers extends StatelessWidget {
  const CustomVideoControllers({
    Key? key,
    required this.homeController,
    required this.onClickedFullScreen,
  }) : super(key: key);

  // final VideoPlayerController controller;
  final HomeController homeController;
  final VoidCallback onClickedFullScreen;

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
              onTap: () async {
                if (homeController.videoPlayerController.value.isPlaying) {
                  homeController.videoPlayerController.pause();
                  homeController.state.isPlaying.value =
                      homeController.videoPlayerController.value.isPlaying;
                  // await Wakelock.toggle(enable: true);
                } else {
                  homeController.videoPlayerController.play();
                  homeController.state.isPlaying.value =
                      homeController.videoPlayerController.value.isPlaying;
                  // await Wakelock.toggle(enable: false);
                }

                // Set value after play or pause
              },
            ),

            //
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        homeController.videoPlayerController.value.isPlaying
                            ? homeController.videoPlayerController.pause()
                            : homeController.videoPlayerController.play();
                        homeController.state.isPlaying.value = homeController
                            .videoPlayerController.value.isPlaying;
                      },
                      child: Icon(
                        homeController.state.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40.0,
                        // semanticLabel: 'Play',
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Progress Bar
                          SfSliderTheme(
                            data: SfSliderThemeData(
                              thumbRadius: 6.5,
                              // overlayRadius: 50,
                            ),
                            child: SfSlider(
                              value: homeController
                                  .state.position.value.inSeconds
                                  .toDouble(),
                              min: -1.0,
                              max: homeController.state.duration.value.inSeconds
                                  .toDouble(),
                              activeColor: Colors.lightGreen,
                              onChanged: (value) async {
                                final currentPosition =
                                    Duration(seconds: value.toInt());
                                await homeController.videoPlayerController
                                    .seekTo(currentPosition);
                              },
                              thumbIcon: const Icon(Icons.circle,
                                  color: Colors.black, size: 6.0),
                            ),
                          ),

                          // left, right, volume, settings, fullscreen buttons
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: _allActions(onClickedFullScreen),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Row _allActions(VoidCallback onClickedFullScreen) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.fast_rewind, color: Colors.white),
        const SizedBox(width: 10),
        const Icon(Icons.fast_forward, color: Colors.white),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            if (homeController.state.isVolumeMuted.value) {
              homeController.videoPlayerController.setVolume(1);
              homeController.state.isVolumeMuted.value = false;
            } else {
              homeController.videoPlayerController.setVolume(0);
              homeController.state.isVolumeMuted.value = true;
            }
            // VolumeController().setVolume(0);
          },
          child: Icon(
            homeController.state.isVolumeMuted.value
                ? Icons.volume_mute
                : Icons.volume_up,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        const Icon(Icons.settings, color: Colors.white),
        Padding(
          padding: const EdgeInsets.only(right: 13, left: 8),
          child: InkWell(
            // onTap: () {
            //   if (homeController.state.isLandScape.value) {
            //     // controller.setLandscape();
            //   } else {

            //   }
            // },
            onTap: onClickedFullScreen,
            child: const Icon(Icons.fullscreen, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
