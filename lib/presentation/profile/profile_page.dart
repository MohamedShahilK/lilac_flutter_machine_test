// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import 'package:lilac_flutter_machine_test/business_logic/profile/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/profile/widgets/custom_button.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            // onTap: () => Get.back(),
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
            ),
          ),
        ),
        body: Obx(
          () => Column(
            children: [
              // Profile Logo
              Stack(
                children: const [
                  CircleAvatar(
                    maxRadius: 60,
                    // child: Image.asset('assets/avatar.jpg'),
                    // backgroundColor: Colors.red,
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      maxRadius: 17,
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),

              //
              Container(),

              //
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  controller.state.userName.value,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 10),
                child: Text(
                  // 'superadmin@gmail.com',
                  controller.state.email.value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              Column(
                children: [
                  // _profileItem(
                  //     name: "Kazhigar", icon: Icons.account_box_outlined),
                  _profileItem(
                    name: controller.state.name.value,
                    icon: Icons.person_2_outlined,
                  ),
                  _profileItem(
                    name: controller.state.email.value,
                    icon: Icons.alternate_email_rounded,
                  ),
                  _profileItem(
                      name: controller.state.phNum.value, icon: Icons.phone),
                  _profileItem(
                      name: controller.convertDatetimeToString(
                                  controller.state.dob.value) ==
                              controller.convertDatetimeToString(DateTime.now())
                          ? 'Select DOB'
                          : controller.convertDatetimeToString(
                              controller.state.dob.value),
                      icon: Icons.date_range_outlined),
                ],
              ),

              // Spacer(),
              // Edit Profile Button
              CustomButton(
                buttonBgColor: Colors.grey[700],
                field: 'Edit Profile',
                onTap: () {
                  Get.toNamed('/editProfile');
                },
              ),

              // LogOut Button
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextButton(
                  onPressed: () async {
                    Loader.show(context,
                        progressIndicator: const CircularProgressIndicator());
                    await controller.performLogOut().then((value) {
                      Loader.hide();
                      Get.offAndToNamed('/');
                    }).onError((error, stackTrace) {
                      Loader.hide();
                    });
                  },
                  style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26))),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.grey[400]!)),
                      elevation: MaterialStateProperty.all(0),
                      fixedSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width * (3 / 8), 45))),
                  child: const Text(
                    'LogOut',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Padding _profileItem({
    required String name,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 70),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.black54),
          const SizedBox(width: 25),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
