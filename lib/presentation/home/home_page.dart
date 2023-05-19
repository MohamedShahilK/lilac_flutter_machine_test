// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_drawer.dart';

import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_buttons.dart';
import 'package:lilac_flutter_machine_test/presentation/home/widgets/custom_video_player.dart';
import 'package:lilac_flutter_machine_test/theme/app_state_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyThemeStateNotifier>(context);
    return SafeArea(
      child: OrientationBuilder(builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return Scaffold(
          drawer: CustomDrawer(controller: controller),
          body: !isPortrait
              ? CustomVideoPlayer(controller: controller)
              : Stack(
                  children: [
                    Column(
                      children: [
                        CustomVideoPlayer(controller: controller),
                        DownloadButton(
                          controller: controller,
                        ),
                      ],
                    ),
                    Positioned(
                      // bottom: 250,
                      bottom: 20,
                      // left: 30,
                      right: 20,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          provider.updateTheme(!provider.isDarkModeOn);
                        },
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: provider.isDarkModeOn
                              ? MaterialStateProperty.all(Colors.white)
                              : MaterialStateProperty.all(Colors.black45),
                          foregroundColor: !provider.isDarkModeOn
                              ? MaterialStateProperty.all(Colors.white)
                              : MaterialStateProperty.all(Colors.black45),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(10),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        icon: provider.isDarkModeOn
                            ? const Icon(Icons.wb_sunny_outlined)
                            : const Icon(Icons.nightlight_outlined),
                        label: Text(
                            'Switch to  ${provider.isDarkModeOn ? 'light' : 'dark'} mode'),
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
