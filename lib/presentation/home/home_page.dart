import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_video_player.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_buttons.dart';
import 'package:video_player/video_player.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return Scaffold(
            body: !isPortrait
                ? CustomVideoPlayer(controller: controller)
                : Column(
                    children: [
                      CustomVideoPlayer(controller: controller),
                      DownloadButton()
                    ],
                  ));
      }),
    );
  }
}
