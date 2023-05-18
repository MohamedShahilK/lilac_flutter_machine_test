// ignore_for_file: avoid_print

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_video_controller.dart';
import 'package:video_player/video_player.dart';
// import 'package:syncfusion_flutter_core/theme.dart';

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    print(
      "isIntialized : ${controller.videoPlayerController.value.isInitialized}",
    );
    return OrientationBuilder(builder: (context, orientation) {
      final isPortrait = orientation == Orientation.portrait;
      // controller.state.isLandScape.value = !isPortrait;
      return SizedBox(
        height: isPortrait ? 250 : null,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: isPortrait ? StackFit.loose : StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            // Rebuilding
            // Obx(
            //   () => controller.state.isInitialized.value
            // ? SizedBox(
            //     child: VideoPlayer(controller.videoPlayerController),
            //   )
            // : Container(
            //     color: Colors.black,
            //     height: 250,
            //     child: const Center(child: CircularProgressIndicator()),
            //   ),
            // ),

            ValueListenableBuilder(
              valueListenable: controller.videoFuture,
              builder: (context, value, _) {
                return value == null
                    ? Container(
                        // color: Colors.black,
                        // height: 250,
                        // // child: const Center(child: CircularProgressIndicator()),
                        )
                    : FutureBuilder(
                        future: value,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return VideoPlayer(
                                controller.videoPlayerController);
                          } else {
                            return Container(
                              color: Colors.black,
                              height: 250,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          }
                        },
                      );
              },
            ),

            // Positioned.fill not much important
            Positioned.fill(
              child: CustomVideoControllers(
                // controller: controller.videoPlayerController,
                homeController: controller,
                onClickedFullScreen: () {
                  if (isPortrait) {
                    AutoOrientation.landscapeRightMode();
                  } else {
                    AutoOrientation.portraitUpMode();
                  }
                },
              ),
            ),

            //
            Positioned(
              top: 15,
              right: 7,
              child: InkWell(
                onTap: () {
                  controller.videoPlayerController.pause();
                  Get.toNamed('/profile');
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    image: const DecorationImage(
                      image: AssetImage('assets/avatar.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

            //
            Positioned(
              top: 15,
              left: 9,
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                // child: const Icon(
                //   Icons.menu,
                //   color: Colors.white,
                //   size: 30,
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 3.5,
                      width: 25,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Container(
                      height: 3.5,
                      width: 17,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Container(
                      height: 3.5,
                      width: 25,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
