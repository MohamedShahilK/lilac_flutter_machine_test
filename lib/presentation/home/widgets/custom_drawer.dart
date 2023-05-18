// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/services/extensions.dart';
import 'package:lilac_flutter_machine_test/utils/data/video_urls.dart';
import 'package:video_player/video_player.dart';

import '../../../business_logic/home/controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 45, left: 10),
        // padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        // height: 180,
        width: 190,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Lilac Machine Test',
                style: TextStyle(color: Colors.grey, fontSize: 23),
              ),
            ),
            ...videos.map((e) {
              return ListTile(
                leading: const Icon(
                  Icons.video_library_sharp,
                ),
                title: Text(e['title']!),
                onTap: () async {
                  Navigator.pop(context);
                  // Get.toNamed('/profile');
                  // if (await controller.checkVideoIsSavedInDevice(e['title']!) == false) {
                  //   await deleteFileFromDevice('_decrypted');
                  // }
                  controller.videoFuture.value =
                      controller.play(e['url']!, e['title']!);
                  controller.state.videoIndex.value = videos
                      .indexWhere((element) => element['url'] == e['url'])
                      .toString();
                  controller.videoFuture.notifyListeners();
                },
              );
            }).toList(),
            // ListTile(
            //   leading: const Icon(
            //     Icons.home,
            //   ),
            //   title: const Text('Profile'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Get.toNamed('/profile');
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.logout,
            //   ),
            //   title: const Text('LogOut'),
            //   onTap: () async {
            //     // Navigator.pop(context);
            //     Loader.show(context,
            //         progressIndicator: const CircularProgressIndicator());
            //     await controller.performLogOut().then((value) {
            //       Loader.hide();
            //       Get.offAndToNamed('/');
            //     }).onError((error, stackTrace) {
            //       Loader.hide();
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
