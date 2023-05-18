// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lilac_flutter_machine_test/business_logic/home/controller.dart';
import 'package:lilac_flutter_machine_test/utils/data/video_urls.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: _RoundButton(
              icon: Icons.keyboard_arrow_left,
              onTap: () {
                final currentIndex =
                    int.parse(controller.state.videoIndex.value);
                if (currentIndex == 0) return;
                controller.videoFuture.value =
                    controller.play(videos[currentIndex - 1]['url']!);
                controller.state.videoIndex.value =
                    (currentIndex - 1).toString();
              },
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text(
              'Download',
              style: TextStyle(color: Colors.black87, fontSize: 15.5),
            ),
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.green,
            ),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _RoundButton(
              icon: Icons.keyboard_arrow_right,
              onTap: () {
                final currentIndex =
                    int.parse(controller.state.videoIndex.value);
                if (currentIndex == videos.length - 1) return;
                controller.videoFuture.value =
                    controller.play(videos[currentIndex + 1]['url']!);
                controller.state.videoIndex.value =
                    (currentIndex + 1).toString();
              },
            ),
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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(13)),
        child: Icon(icon, size: 21, color: Colors.black87),
      ),
    );
  }
}
