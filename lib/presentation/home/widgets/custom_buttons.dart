// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: _RoundButton(icon: Icons.keyboard_arrow_left),
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
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: _RoundButton(icon: Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;

  const _RoundButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13)
      ),
      child: Icon(icon, size: 21,color: Colors.black87),
    );
  }
}
