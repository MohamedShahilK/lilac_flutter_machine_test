import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_video_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    print(
        "isIntialized : ${controller.videoPlayerController.value.isInitialized}");
    return Obx(
      () => controller.state.isInitialized.value
          ? SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    child: VideoPlayer(controller.videoPlayerController),
                  ),
                  CustomVideoControllers(
                    // controller: controller.videoPlayerController,
                    homeController: controller,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SfSliderTheme(
                        data: SfSliderThemeData(
                          thumbRadius: 6.5,
                          overlayRadius: 50,
                        ),
                        child: SfSlider(
                          value: controller.state.position.value.inSeconds
                              .toDouble(),
                          min: 0.0,
                          max: controller.state.duration.value.inSeconds
                              .toDouble(),
                          activeColor: Colors.lightGreen,
                          onChanged: (value) async {
                            final currentPosition =
                                Duration(seconds: value.toInt());
                            await controller.videoPlayerController
                                .seekTo(currentPosition);
                          },
                          thumbIcon: const Icon(Icons.circle,
                              color: Colors.black, size: 6.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.black,
              height: 200,
              child: const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
