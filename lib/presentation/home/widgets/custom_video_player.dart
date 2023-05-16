import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_video_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:video_player/video_player.dart';
// import 'package:syncfusion_flutter_core/theme.dart';

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    print(
        "isIntialized : ${controller.videoPlayerController.value.isInitialized}");
    return Obx(
      () => controller.state.isInitialized.value
          ? OrientationBuilder(builder: (context, orientation) {
              final isPortrait = orientation == Orientation.portrait;
              return SizedBox(
                height: isPortrait ? 250 : null,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: isPortrait ? StackFit.loose : StackFit.expand,
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      child: VideoPlayer(controller.videoPlayerController),
                    ),
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
                  ],
                ),
              );
            })
          : Container(
              color: Colors.black,
              height: 250,
              child: const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
