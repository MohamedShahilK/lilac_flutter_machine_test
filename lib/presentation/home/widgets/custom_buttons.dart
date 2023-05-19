// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';

import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
import 'package:lilac_flutter_machine_test/services/extensions.dart';
import 'package:lilac_flutter_machine_test/theme/app_state_notifier.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';
import 'package:lilac_flutter_machine_test/utils/data/video_urls.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  String downloadMsg = '';
  double percentage = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyThemeStateNotifier>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: _RoundButton(
                  icon: Icons.keyboard_arrow_left,
                  onTap: () {
                    final currentIndex =
                        int.parse(widget.controller.state.videoIndex.value);
                    if (currentIndex == 0) return;
                    widget.controller.videoFuture.value =
                        widget.controller.play(
                      videos[currentIndex - 1]['url']!,
                      videos[currentIndex - 1]['title']!,
                    );
                    widget.controller.videoFuture.notifyListeners();
                    widget.controller.state.videoIndex.value =
                        (currentIndex - 1).toString();
                  },
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (!widget
                      .controller.videoPlayerController.value.isInitialized) {
                    showTextMessageToaster(
                        "please wait until the video is loaded completed");
                    return;
                  }
                  final dio = Dio();
                  // String imgurl =
                  // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
                  // 'https://www.fluttercampus.com/img/banner.png';

                  final currentVideoIndex =
                      int.parse(widget.controller.state.videoIndex.value);
                  String downloadUrl = videos[currentVideoIndex]['url']!;
                  // Step 1
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    //add more permission to request here
                  ].request();

                  // Step 2
                  if (statuses[Permission.storage]!.isGranted) {
                    // var dir = await DownloadsPathProvider.downloadsDirectory;
                    var dir = await DownloadsPath.downloadsDirectory();
                    if (dir != null) {
                      // String fileName = "banner";
                      // String fileName = "banner";
                      String fileName = videos[currentVideoIndex]['title']!;
                      // String savename = "secret/banner.png";
                      String savename =
                          "secret/${fileName.toLowerCase().replaceAll(' ', '')}.mp4";
                      String savePath = "${dir.path}/$savename";
                      // print(savePath);

                      // Step 3
                      try {
                        await dio.download(
                          downloadUrl,
                          savePath,
                          onReceiveProgress: (received, total) {
                            print(
                                "11111111111111111111111 : $received - $total");

                            // if (total != -1) {
                            //   //you can build progressbar feature too
                            // }

                            var percentage = received / total * 100;
                            setState(() {
                              this.percentage = percentage;
                              downloadMsg =
                                  'Downloading... ${percentage.floor()} %';
                            });
                          },
                        ).then((value) async {
                          await encryptFile(savePath, fileName);

                          await deleteFileFromDevice(fileName);

                          Future.delayed(
                            const Duration(seconds: 3),
                            () {
                              showTextMessageToaster(
                                  'Downloaded file removed from device');
                            },
                          );

                          Future.delayed(
                            const Duration(seconds: 6),
                            () async {
                              await decryptFile(fileName);
                              final currentIndex = int.parse(
                                  widget.controller.state.videoIndex.value);
                              widget.controller.videoFuture.value =
                                  widget.controller.play(
                                videos[currentIndex]['url']!,
                                videos[currentIndex]['title']!,
                              );
                              widget.controller.videoFuture.notifyListeners();
                            },
                          );
                          // await decryptFile(fileName);
                        });
                      } on DioError catch (e) {
                        print(e.message);
                      }
                    }
                  } else {
                    print("No permission to read and write.");
                  }
                },
                label: Text(
                  'Download',
                  style: TextStyle(
                      color:
                          provider.isDarkModeOn ? Colors.white : Colors.black87,
                      fontSize: 15.5),
                ),
                icon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: provider.isDarkModeOn ? Colors.white : Colors.green,
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                      provider.isDarkModeOn ? Colors.grey : Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _RoundButton(
                  icon: Icons.keyboard_arrow_right,
                  onTap: () async {
                    final currentIndex =
                        int.parse(widget.controller.state.videoIndex.value);
                    if (currentIndex == videos.length - 1) return;
                    widget.controller.videoFuture.value = widget.controller
                        .play(videos[currentIndex + 1]['url']!,
                            videos[currentIndex + 1]['title']!);
                    widget.controller.state.videoIndex.value =
                        (currentIndex + 1).toString();
                  },
                ),
              ),
            ],
          ),

          // Download Progress
          const SizedBox(height: 32),
          Text(
            downloadMsg,
            style: TextStyle(
                color: Provider.of<MyThemeStateNotifier>(context).isDarkModeOn
                    ? Colors.white
                    : Colors.black),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyThemeStateNotifier>(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: provider.isDarkModeOn ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon,
            size: 21,
            color: provider.isDarkModeOn ? Colors.white : Colors.black87),
      ),
    );
  }
}
