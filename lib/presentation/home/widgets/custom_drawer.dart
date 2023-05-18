import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

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
        height: 180,
        width: 190,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Lilac Machine Test',
                style: TextStyle(color: Colors.grey, fontSize: 23),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/profile');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('LogOut'),
              onTap: () async {
                // Navigator.pop(context);
                Loader.show(context,
                    progressIndicator: const CircularProgressIndicator());
                await controller.performLogOut().then((value) {
                  Loader.hide();
                  Get.offAndToNamed('/');
                }).onError((error, stackTrace) {
                  Loader.hide();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
